import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logger/logger.dart';
import '../../core/path_loss.dart';
import '../../domain/entities/advertiser.dart';
import '../../domain/entities/reading.dart';
import '../../domain/entities/tracker_snapshot.dart';
import '../../domain/repositories/ble_repository.dart';
import '../../domain/repositories/history_repository.dart';

class BleRepositoryImpl implements BleRepository {
  static const Duration _historyWindow = Duration(seconds: 600);
  static const Duration _advertiserTtl = Duration(seconds: 20);

  final HistoryRepository? historyRepository;
  final PathLossModel pathLoss;
  final Logger _logger = Logger();

  final List<Reading> _readings = [];
  final Map<String, Advertiser> _advertisers = {};
  String? _radioIssue;
  bool _bluetoothOn = false;
  String? _targetName;
  final DateTime _startedAt = DateTime.now();

  StreamSubscription<List<ScanResult>>? _scanSub;
  StreamSubscription<BluetoothAdapterState>? _stateSub;
  Timer? _pruneTimer;

  final StreamController<TrackerSnapshot> _controller =
      StreamController<TrackerSnapshot>.broadcast();

  BleRepositoryImpl({
    this.historyRepository,
    this.pathLoss = const PathLossModel(),
  });

  @override
  Stream<TrackerSnapshot> trackerStream({String? targetName}) {
    _targetName = targetName;
    unawaited(startTracking(targetName: targetName));
    return _controller.stream;
  }

  @override
  Future<void> startTracking({String? targetName}) async {
    _targetName = targetName;
    _readings.clear();
    _advertisers.clear();

    await _stateSub?.cancel();
    _stateSub = FlutterBluePlus.adapterState.listen((state) {
      _bluetoothOn = state == BluetoothAdapterState.on;
      _radioIssue = switch (state) {
        BluetoothAdapterState.on => null,
        BluetoothAdapterState.off => 'Bluetooth is off. Waiting for it to come back on.',
        BluetoothAdapterState.unauthorized => 'Bluetooth permission denied.',
        _ => 'Bluetooth unavailable.',
      };
      if (state == BluetoothAdapterState.on) {
        unawaited(_beginScan());
      }
      _emit();
    });

    _pruneTimer?.cancel();
    _pruneTimer = Timer.periodic(const Duration(seconds: 1), (_) => _prune());
  }

  Future<void> _beginScan() async {
    try {
      await _scanSub?.cancel();
      await FlutterBluePlus.startScan(
        continuousUpdates: true,
        androidUsesFineLocation: true,
      );
      _scanSub = FlutterBluePlus.scanResults.listen(_onResults, onError: (e) {
        _logger.e('scan error', error: e);
      });
    } catch (e, st) {
      _logger.e('failed to start scan', error: e, stackTrace: st);
    }
  }

  void _onResults(List<ScanResult> results) {
    final now = DateTime.now();
    for (final r in results) {
      final id = r.device.remoteId.str;
      final advertisedName = r.advertisementData.advName.isNotEmpty
          ? r.advertisementData.advName
          : (r.device.platformName.isNotEmpty ? r.device.platformName : null);

      final existing = _advertisers[id];
      if (existing != null) {
        existing.feed(r.rssi, now, advertisedName);
      } else {
        _advertisers[id] = Advertiser(
          id: id,
          name: advertisedName,
          peak: r.rssi,
          last: now,
          initialRssi: r.rssi.toDouble(),
        );
      }

      final target = _targetName;
      if (target != null) {
        final name = _advertisers[id]!.name;
        if (name != null && name.toLowerCase().contains(target.toLowerCase())) {
          _record(r.rssi, 'advert', deviceKey: id, deviceLabel: name);
        }
      }
    }
    _emit();
  }

  void _record(int rssi, String source, {String? deviceKey, String? deviceLabel}) {
    if (rssi >= 0 || rssi <= -127) return;
    final reading = Reading(
      rssi: rssi,
      at: DateTime.now(),
      source: source,
      distanceMeters: pathLoss.distanceMeters(rssi.toDouble()),
    );
    _readings.add(reading);

    final repo = historyRepository;
    if (repo != null && deviceKey != null) {
      unawaited(repo.recordReading(
        deviceKey: deviceKey,
        deviceLabel: deviceLabel ?? deviceKey,
        reading: reading,
      ));
    }
  }

  void _prune() {
    final now = DateTime.now();
    _readings.removeWhere((r) => now.difference(r.at) >= _historyWindow);
    _advertisers.removeWhere((_, a) => now.difference(a.last) >= _advertiserTtl);
    _emit();
  }

  void _emit() {
    final now = DateTime.now();
    if (_controller.isClosed) return;
    _controller.add(TrackerSnapshot(
      targetName: _targetName,
      at: now,
      elapsedSeconds: now.difference(_startedAt).inSeconds,
      readings: List.unmodifiable(_readings),
      advertisers: Map.unmodifiable(_advertisers),
      bluetoothOn: _bluetoothOn,
      radioIssue: _radioIssue,
    ));
  }

  @override
  Future<void> stopTracking() async {
    await _scanSub?.cancel();
    await _stateSub?.cancel();
    _pruneTimer?.cancel();
    await FlutterBluePlus.stopScan();
  }

  @override
  Future<List<PairedDeviceInfo>> pairedDevices() async {
    final systemDevices = await FlutterBluePlus.systemDevices([]);
    final bonded = await FlutterBluePlus.bondedDevices;
    final merged = <String, BluetoothDevice>{};
    for (final d in [...systemDevices, ...bonded]) {
      merged[d.remoteId.str] = d;
    }
    final infos = <PairedDeviceInfo>[];
    for (final d in merged.values) {
      final state = await d.connectionState.first;
      infos.add(PairedDeviceInfo(
        id: d.remoteId.str,
        name: d.platformName.isNotEmpty ? d.platformName : 'unknown',
        connected: state == BluetoothConnectionState.connected,
      ));
    }
    return infos;
  }

  Future<void> dispose() async {
    await stopTracking();
    await _controller.close();
  }
}
