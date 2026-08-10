import '../entities/tracker_snapshot.dart';

abstract class BleRepository {
  Stream<TrackerSnapshot> trackerStream({String? targetName});

  Future<void> startTracking({String? targetName});

  Future<void> stopTracking();

  Future<List<PairedDeviceInfo>> pairedDevices();
}

class PairedDeviceInfo {
  final String id;
  final String name;
  final bool connected;

  const PairedDeviceInfo({
    required this.id,
    required this.name,
    required this.connected,
  });
}
