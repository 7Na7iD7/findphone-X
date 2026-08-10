import 'package:permission_handler/permission_handler.dart';

class BlePermissions {
  static Future<bool> ensureGranted() async {
    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    return statuses.values.every((s) => s.isGranted || s.isLimited);
  }
}
