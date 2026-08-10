class Reading {
  final int rssi;
  final DateTime at;
  final String source;
  final double? distanceMeters;

  const Reading({
    required this.rssi,
    required this.at,
    required this.source,
    this.distanceMeters,
  });
}

extension ReadingsWindow on List<Reading> {
  List<Reading> since(Duration duration, DateTime now) {
    final cutoff = now.subtract(duration);
    var i = length;
    while (i > 0 && this[i - 1].at.isAfter(cutoff)) {
      i--;
    }
    return sublist(i);
  }
}

extension ReadingsStats on Iterable<Reading> {
  int? get medianRssi {
    final values = map((r) => r.rssi).toList()..sort();
    if (values.isEmpty) return null;
    return values[values.length ~/ 2];
  }

  int? get peakRssi {
    if (isEmpty) return null;
    return map((r) => r.rssi).reduce((a, b) => a > b ? a : b);
  }
}
