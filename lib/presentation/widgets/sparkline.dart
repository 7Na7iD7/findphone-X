import 'package:flutter/material.dart';
import '../../domain/entities/reading.dart';
import '../../domain/entities/proximity.dart';

class Sparkline extends StatelessWidget {
  final List<Reading> readings;
  final Color color;
  final double height;

  const Sparkline({
    super.key,
    required this.readings,
    required this.color,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _SparklinePainter(readings: readings, color: color),
        size: Size.infinite,
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<Reading> readings;
  final Color color;

  _SparklinePainter({required this.readings, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (readings.isEmpty) return;
    final barWidth = size.width / readings.length;
    final paint = Paint()..color = color;

    for (var i = 0; i < readings.length; i++) {
      final fraction = Proximity.fraction(readings[i].rssi);
      final barHeight = size.height * fraction;
      final rect = Rect.fromLTWH(
        i * barWidth,
        size.height - barHeight,
        barWidth * 0.7,
        barHeight,
      );
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) =>
      oldDelegate.readings != readings;
}
