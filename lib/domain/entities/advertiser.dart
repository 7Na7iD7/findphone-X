import '../../core/kalman_filter.dart';

class Advertiser {
  final String id;
  String? name;
  int peak;
  DateTime last;
  final KalmanFilter1D _filter;

  Advertiser({
    required this.id,
    this.name,
    required this.peak,
    required this.last,
    double initialRssi = -70,
  }) : _filter = KalmanFilter1D(initialEstimate: initialRssi);

  double get smoothed => _filter.value;

  String get label => name ?? 'unknown';

  void feed(int rssi, DateTime at, String? advertisedName) {
    name = name ?? advertisedName;
    if (rssi > peak) peak = rssi;
    _filter.update(rssi.toDouble());
    last = at;
  }
}
