import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class Clicker {
  static const double touching = -50;
  static const double distant = -95;
  static const Duration fastest = Duration(milliseconds: 70);
  static const Duration slowest = Duration(milliseconds: 1000);

  final AudioPlayer _player = AudioPlayer();
  int? _rssi;
  Timer? _timer;
  bool _disposed = false;

  Future<void> start() async {
    await _player.setSource(AssetSource('sounds/tink.mp3'));
    _schedule();
  }

  void update(int? rssi) {
    _rssi = rssi;
  }

  Duration _interval(int rssi) {
    final ramp = (rssi - distant) / (touching - distant);
    final clamped = ramp.clamp(0.0, 1.0);
    final span = slowest.inMilliseconds - fastest.inMilliseconds;
    final ms = slowest.inMilliseconds - (clamped * span);
    return Duration(milliseconds: max(fastest.inMilliseconds, ms.round()));
  }

  void _schedule() {
    if (_disposed) return;
    final wait = _rssi != null ? _interval(_rssi!) : slowest;
    _timer = Timer(wait, () {
      if (_disposed) return;
      if (_rssi != null) {
        _player.play(AssetSource('sounds/tink.mp3'));
      }
      _schedule();
    });
  }

  Future<void> dispose() async {
    _disposed = true;
    _timer?.cancel();
    await _player.dispose();
  }
}
