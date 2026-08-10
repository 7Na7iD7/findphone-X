import 'package:drift/drift.dart';
import '../../domain/entities/reading.dart';
import '../../domain/repositories/history_repository.dart';
import '../local/app_database.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final AppDatabase db;

  const HistoryRepositoryImpl(this.db);

  @override
  Future<void> recordReading({
    required String deviceKey,
    required String deviceLabel,
    required Reading reading,
  }) async {
    await db.upsertDevice(deviceKey, deviceLabel, reading.at);
    await db.insertReading(SignalReadingsCompanion.insert(
      deviceKey: deviceKey,
      rssi: reading.rssi,
      source: reading.source,
      at: reading.at,
      distanceMeters: Value(reading.distanceMeters),
    ));
  }

  @override
  Future<List<Reading>> readingsFor(String deviceKey, {Duration? within}) async {
    final cutoff = within == null
        ? DateTime.fromMillisecondsSinceEpoch(0)
        : DateTime.now().subtract(within);
    final rows = await db.readingsSince(deviceKey, cutoff);
    return rows
        .map((r) => Reading(
              rssi: r.rssi,
              at: r.at,
              source: r.source,
              distanceMeters: r.distanceMeters,
            ))
        .toList();
  }

  @override
  Future<void> pruneOlderThan(Duration age) async {
    await db.deleteOlderThan(DateTime.now().subtract(age));
  }

  @override
  Future<List<String>> recentDeviceKeys({int limit = 20}) async {
    final rows = await db.recentDevices(limit);
    return rows.map((d) => d.key).toList();
  }
}
