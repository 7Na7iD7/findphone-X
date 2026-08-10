import 'reading.dart';

class ProximityBand {
  final int floor;
  final String label;
  const ProximityBand(this.floor, this.label);
}

class Proximity {
  static const List<ProximityBand> bands = [
    ProximityBand(-45, "ARM'S REACH"),
    ProximityBand(-60, 'SAME TABLE'),
    ProximityBand(-72, 'SAME ROOM'),
    ProximityBand(-85, 'FAR / BEHIND SOMETHING'),
    ProximityBand(-1000, 'VERY FAR OR SHIELDED'),
  ];

  static int bandIndex(int rssi) {
    for (var i = 0; i < bands.length; i++) {
      if (rssi >= bands[i].floor) return i;
    }
    return bands.length - 1;
  }

  static String describe(int rssi) => bands[bandIndex(rssi)].label;

  static double fraction(int rssi) {
    final clamped = rssi.clamp(-100, -30);
    return (clamped + 100.0) / 70.0;
  }
}

enum Trend { warmer, colder, steady, unknown }

class TrendCalculator {
  static const Duration liveWindow = Duration(seconds: 4);
  static const Duration window = Duration(seconds: 12);
  static const int threshold = 3;

  static Trend of(List<Reading> readings, DateTime now) {
    final near = readings.since(liveWindow, now);
    final wide = readings.since(window, now);
    final priorCount = wide.length - near.length;
    if (near.length < 2 || priorCount < 2) return Trend.unknown;
    final prior = wide.sublist(0, priorCount);
    final newer = near.medianRssi;
    final older = prior.medianRssi;
    if (newer == null || older == null) return Trend.unknown;
    final diff = newer - older;
    if (diff > threshold) return Trend.warmer;
    if (diff < -threshold) return Trend.colder;
    return Trend.steady;
  }
}
