import 'package:flutter_test/flutter_test.dart';
import 'package:findphonex/core/path_loss.dart';

void main() {
  group('PathLossModel', () {
    test('rssi equal to measured power at 1m returns ~1 meter', () {
      const model = PathLossModel(measuredPowerAt1m: -59, pathLossExponent: 2.5);
      final d = model.distanceMeters(-59);
      expect(d, closeTo(1.0, 0.01));
    });

    test('weaker rssi yields larger estimated distance', () {
      const model = PathLossModel();
      final near = model.distanceMeters(-50);
      final far = model.distanceMeters(-90);
      expect(far, greaterThan(near));
    });

    test('open space exponent yields smaller distance than cluttered indoor', () {
      final rssi = -75.0;
      final open = PathLossModel.openSpace.distanceMeters(rssi);
      final cluttered = PathLossModel.indoorCluttered.distanceMeters(rssi);
      expect(open, lessThan(cluttered));
    });
  });
}
