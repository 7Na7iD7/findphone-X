import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/settings_provider.dart';
import '../../services/permissions.dart';
import 'survey_screen.dart';
import 'hunt_screen.dart';
import 'paired_devices_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _nameController = TextEditingController();

  Future<bool> _ensurePermissions() async {
    final granted = await BlePermissions.ensureGranted();
    if (!granted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('دسترسی بلوتوث و موقعیت مکانی لازم است.')),
      );
    }
    return granted;
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);
    final settingsController = ref.read(appSettingsProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('findphone X'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'دستگاه بلوتوث نزدیک را با شدت سیگنال پیدا کن',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'نام دستگاه (اختیاری)',
                labelStyle: const TextStyle(color: Colors.white54),
                hintText: 'مثلا iPhone',
                hintStyle: const TextStyle(color: Colors.white24),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: settings.soundEnabled,
              onChanged: settingsController.setSound,
              title: const Text('صدای نزدیک‌شدن', style: TextStyle(color: Colors.white)),
              activeThumbColor: Colors.greenAccent,
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              value: settings.redact,
              onChanged: settingsController.setRedact,
              title: const Text('مخفی‌کردن آدرس (ضبط صفحه)', style: TextStyle(color: Colors.white)),
              activeThumbColor: Colors.greenAccent,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () async {
                if (!await _ensurePermissions()) return;
                final name = _nameController.text.trim();
                if (!mounted) return;
                if (name.isEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SurveyScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HuntScreen(targetName: name)),
                  );
                }
              },
              child: Text(_nameController.text.trim().isEmpty
                  ? 'حالت جستجوی همه دستگاه‌ها'
                  : 'ردیابی این دستگاه'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white24),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () async {
                if (!await _ensurePermissions()) return;
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PairedDevicesScreen()),
                );
              },
              child: const Text('دستگاه‌های جفت‌شده'),
            ),
          ],
        ),
      ),
    );
  }
}
