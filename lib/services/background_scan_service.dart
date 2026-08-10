import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

@pragma('vm:entry-point')
void startBackgroundScanCallback() {
  FlutterForegroundTask.setTaskHandler(BackgroundScanTaskHandler());
}

class BackgroundScanTaskHandler extends TaskHandler {
  StreamSubscription<List<ScanResult>>? _sub;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    await FlutterBluePlus.startScan(
      continuousUpdates: true,
      androidUsesFineLocation: true,
    );
    _sub = FlutterBluePlus.scanResults.listen((results) {
      if (results.isEmpty) return;
      final strongest = results.reduce((a, b) => a.rssi > b.rssi ? a : b);
      FlutterForegroundTask.updateService(
        notificationTitle: 'findphone در حال اسکن',
        notificationText: 'قوی‌ترین سیگنال: ${strongest.rssi} dBm',
      );
    });
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    await _sub?.cancel();
    await FlutterBluePlus.stopScan();
  }
}

class BackgroundScanService {
  static Future<void> initialize() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'findphone_scan',
        channelName: 'اسکن بلوتوث findphone',
        channelDescription: 'اسکن دستگاه‌های بلوتوث در پس‌زمینه',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(3000),
        autoRunOnBoot: false,
        allowWifiLock: false,
      ),
    );
  }

  static Future<void> start() async {
    final running = await FlutterForegroundTask.isRunningService;
    if (running) return;
    await FlutterForegroundTask.startService(
      notificationTitle: 'findphone در حال اسکن',
      notificationText: 'در حال جستجوی دستگاه‌های بلوتوث نزدیک',
      callback: startBackgroundScanCallback,
    );
  }

  static Future<void> stop() async {
    await FlutterForegroundTask.stopService();
  }
}
