import 'package:flutter_test/flutter_test.dart';
import 'package:findphonex/core/kalman_filter.dart';

void main() {
  group('KalmanFilter1D', () {
    test('first update returns the raw measurement', () {
      final filter = KalmanFilter1D();
      expect(filter.update(-70), -70);
    });

    test('smooths a noisy sequence toward the true value', () {
      final filter = KalmanFilter1D(initialEstimate: -70);
      final noisy = [-70, -85, -68, -90, -69, -71, -67, -95, -70, -68];
      double last = -70;
      for (final v in noisy) {
        last = filter.update(v.toDouble());
      }
      expect(last, greaterThan(-85));
      expect(last, lessThan(-60));
    });

    test('reset clears state back to initial estimate', () {
      final filter = KalmanFilter1D(initialEstimate: -70);
      filter.update(-40);
      filter.reset(initialEstimate: -80);
      expect(filter.value, -80);
    });
  });
}
