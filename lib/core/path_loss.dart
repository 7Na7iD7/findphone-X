import 'dart:math';

class PathLossModel {
  final double measuredPowerAt1m;
  final double pathLossExponent;

  const PathLossModel({
    this.measuredPowerAt1m = -59,
    this.pathLossExponent = 2.5,
  });

  double distanceMeters(double rssi) {
    if (rssi == 0) return -1;
    final ratio = (measuredPowerAt1m - rssi) / (10 * pathLossExponent);
    return pow(10, ratio).toDouble();
  }

  static const PathLossModel indoorCluttered = PathLossModel(
    measuredPowerAt1m: -59,
    pathLossExponent: 3.0,
  );

  static const PathLossModel openSpace = PathLossModel(
    measuredPowerAt1m: -59,
    pathLossExponent: 2.0,
  );
}
