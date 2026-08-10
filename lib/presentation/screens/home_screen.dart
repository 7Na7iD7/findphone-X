import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/settings_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../services/permissions.dart';
import 'survey_screen.dart';
import 'hunt_screen.dart';
import 'paired_devices_screen.dart';
import 'settings_screen.dart';

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
        SnackBar(content: Text(context.l10n.t('permissionsRequired'))),
      );
    }
    return granted;
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);
    final settingsController = ref.read(appSettingsProvider.notifier);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(l10n.t('appTitle')),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: l10n.t('settingsTooltip'),
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.t('homeSubtitle'),
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: l10n.t('deviceNameLabel'),
                labelStyle: const TextStyle(color: Colors.white54),
                hintText: l10n.t('deviceNameHint'),
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
              title: Text(l10n.t('soundEnabledLabel'),
                  style: const TextStyle(color: Colors.white)),
              activeThumbColor: Colors.greenAccent,
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              value: settings.redact,
              onChanged: settingsController.setRedact,
              title: Text(l10n.t('redactLabel'),
                  style: const TextStyle(color: Colors.white)),
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
                    MaterialPageRoute(
                        builder: (_) => HuntScreen(targetName: name)),
                  );
                }
              },
              child: Text(_nameController.text.trim().isEmpty
                  ? l10n.t('surveyButton')
                  : l10n.t('huntButton')),
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
                  MaterialPageRoute(
                      builder: (_) => const PairedDevicesScreen()),
                );
              },
              child: Text(l10n.t('pairedDevicesButton')),
            ),
          ],
        ),
      ),
    );
  }
}
