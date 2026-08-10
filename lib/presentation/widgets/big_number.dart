import 'package:flutter/material.dart';

class BigNumber extends StatelessWidget {
  final int value;
  final Color color;

  const BigNumber({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.w800,
            color: color,
            fontFeatures: const [FontFeature.tabularFigures()],
            height: 1,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'dBm',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: color.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
