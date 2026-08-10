import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/clicker.dart';

class ClickerController extends StateNotifier<bool> {
  Clicker? _clicker;

  ClickerController() : super(false);

  Future<void> enable() async {
    if (_clicker != null) return;
    _clicker = Clicker();
    await _clicker!.start();
    state = true;
  }

  void update(int? rssi) {
    _clicker?.update(rssi);
  }

  Future<void> disable() async {
    await _clicker?.dispose();
    _clicker = null;
    state = false;
  }

  @override
  void dispose() {
    _clicker?.dispose();
    super.dispose();
  }
}

final clickerControllerProvider =
    StateNotifierProvider.autoDispose<ClickerController, bool>((ref) {
  return ClickerController();
});
