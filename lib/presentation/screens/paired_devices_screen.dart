import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/paired_devices_provider.dart';
import '../../application/providers/settings_provider.dart';

class PairedDevicesScreen extends ConsumerWidget {
  const PairedDevicesScreen({super.key});

  String _maskAddress(String address) => '••:••:••:••:••:••';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(pairedDevicesProvider);
    final redact = ref.watch(appSettingsProvider).redact;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('دستگاه‌های جفت‌شده'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: devicesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.greenAccent),
        ),
        error: (err, st) => Center(
          child: Text('خطا: $err', style: const TextStyle(color: Colors.white70)),
        ),
        data: (devices) {
          if (devices.isEmpty) {
            return const Center(
              child: Text('هیچ دستگاه جفت‌شده‌ای پیدا نشد.',
                  style: TextStyle(color: Colors.white38)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: devices.length,
            separatorBuilder: (_, __) => const Divider(color: Colors.white12),
            itemBuilder: (context, i) {
              final d = devices[i];
              final address = redact ? _maskAddress(d.id) : d.id;
              return ListTile(
                title: Text(d.name, style: const TextStyle(color: Colors.white)),
                subtitle: Text(address, style: const TextStyle(color: Colors.white38)),
                trailing: Text(
                  d.connected ? 'متصل' : 'غیرمتصل',
                  style: TextStyle(
                    color: d.connected ? Colors.greenAccent : Colors.white24,
                    fontSize: 12,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
