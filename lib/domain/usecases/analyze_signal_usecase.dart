import '../../core/path_loss.dart';
import '../entities/reading.dart';
import '../entities/proximity.dart';

class AnalyzeSignalUseCase {
  final PathLossModel pathLoss;

  const AnalyzeSignalUseCase({this.pathLoss = const PathLossModel()});

  double estimateDistanceMeters(int rssi) =>
      pathLoss.distanceMeters(rssi.toDouble());

  Trend trendOf(List<Reading> readings, DateTime now) =>
      TrendCalculator.of(readings, now);
}
