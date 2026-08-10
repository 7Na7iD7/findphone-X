import 'package:flutter/material.dart';
import '../../domain/entities/proximity.dart';

Color toneForRssi(int rssi) {
  switch (Proximity.bandIndex(rssi)) {
    case 0:
      return Colors.greenAccent;
    case 1:
      return Colors.green;
    case 2:
      return Colors.yellow;
    case 3:
      return Colors.orange;
    default:
      return Colors.redAccent;
  }
}
