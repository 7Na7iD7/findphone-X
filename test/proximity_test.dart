import 'package:flutter_test/flutter_test.dart';
import 'package:findphonex/domain/entities/proximity.dart';
import 'package:findphonex/domain/entities/reading.dart';

void main() {
  group('Proximity', () {
    test('classifies arm\'s reach correctly', () {
      expect(Proximity.describe(-40), "ARM'S REACH");
    });

    test('classifies very far or shielded for weak signal', () {
      expect(Proximity.describe(-95), 'VERY FAR OR SHIELDED');
    });

    test('fraction is clamped between 0 and 1', () {
      expect(Proximity.fraction(-10), 1.0);
      expect(Proximity.fraction(-150), 0.0);
    });
  });

  group('TrendCalculator', () {
    test('reports unknown with insufficient history', () {
      final now = DateTime.now();
      final readings = [Reading(rssi: -60, at: now, source: 'test')];
      expect(TrendCalculator.of(readings, now), Trend.unknown);
    });

    test('detects warmer trend when signal strengthens', () {
      final now = DateTime.now();
      final readings = <Reading>[
        Reading(rssi: -80, at: now.subtract(const Duration(seconds: 10)), source: 't'),
        Reading(rssi: -82, at: now.subtract(const Duration(seconds: 9)), source: 't'),
        Reading(rssi: -50, at: now.subtract(const Duration(seconds: 2)), source: 't'),
        Reading(rssi: -48, at: now.subtract(const Duration(seconds: 1)), source: 't'),
      ];
      expect(TrendCalculator.of(readings, now), Trend.warmer);
    });

    test('detects colder trend when signal weakens', () {
      final now = DateTime.now();
      final readings = <Reading>[
        Reading(rssi: -45, at: now.subtract(const Duration(seconds: 10)), source: 't'),
        Reading(rssi: -46, at: now.subtract(const Duration(seconds: 9)), source: 't'),
        Reading(rssi: -80, at: now.subtract(const Duration(seconds: 2)), source: 't'),
        Reading(rssi: -82, at: now.subtract(const Duration(seconds: 1)), source: 't'),
      ];
      expect(TrendCalculator.of(readings, now), Trend.colder);
    });
  });
}
