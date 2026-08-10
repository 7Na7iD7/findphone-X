import 'package:flutter/material.dart';
import '../../domain/entities/proximity.dart';

class SignalBar extends StatelessWidget {
  final int rssi;
  final Color color;
  final double height;

  const SignalBar({
    super.key,
    required this.rssi,
    required this.color,
    this.height = 14,
  });

  @override
  Widget build(BuildContext context) {
    final fraction = Proximity.fraction(rssi);
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Stack(
        children: [
          Container(height: height, color: color.withValues(alpha: 0.15)),
          FractionallySizedBox(
            widthFactor: fraction,
            child: Container(height: height, color: color),
          ),
        ],
      ),
    );
  }
}
