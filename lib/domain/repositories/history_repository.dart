import '../entities/reading.dart';

abstract class HistoryRepository {
  Future<void> recordReading({
    required String deviceKey,
    required String deviceLabel,
    required Reading reading,
  });

  Future<List<Reading>> readingsFor(String deviceKey, {Duration? within});

  Future<void> pruneOlderThan(Duration age);

  Future<List<String>> recentDeviceKeys({int limit = 20});
}
