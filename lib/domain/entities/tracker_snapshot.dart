import 'reading.dart';
import 'advertiser.dart';

class TrackerSnapshot {
  final String? targetName;
  final DateTime at;
  final int elapsedSeconds;
  final List<Reading> readings;
  final Map<String, Advertiser> advertisers;
  final bool bluetoothOn;
  final String? radioIssue;

  const TrackerSnapshot({
    required this.targetName,
    required this.at,
    required this.elapsedSeconds,
    required this.readings,
    required this.advertisers,
    required this.bluetoothOn,
    required this.radioIssue,
  });

  static final TrackerSnapshot empty = TrackerSnapshot(
    targetName: null,
    at: DateTime.fromMillisecondsSinceEpoch(0),
    elapsedSeconds: 0,
    readings: const [],
    advertisers: const {},
    bluetoothOn: false,
    radioIssue: null,
  );

  int? get live {
    final recent = readings.since(const Duration(seconds: 4), at);
    if (recent.isNotEmpty) return recent.medianRssi;
    return readings.isNotEmpty ? readings.last.rssi : null;
  }

  bool get isFresh {
    if (readings.isEmpty) return false;
    return at.difference(readings.last.at) < const Duration(seconds: 10);
  }

  List<Advertiser> get sortedAdvertisers {
    final list = advertisers.values.toList();
    list.sort((a, b) => b.smoothed.compareTo(a.smoothed));
    return list;
  }
}
