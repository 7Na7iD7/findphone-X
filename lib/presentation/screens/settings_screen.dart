import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../application/providers/settings_provider.dart';
import '../../l10n/app_localizations.dart';

class _Developer {
  final String name;
  final String githubUrl;
  const _Developer({required this.name, required this.githubUrl});

  String get handle => '@${githubUrl.split('/').last}';
}

const _developers = [
  _Developer(name: 'Navid Afzali', githubUrl: 'https://github.com/7Na7iD7'),
  _Developer(name: 'Niki Farzami', githubUrl: 'https://github.com/nikifarzami'),
];

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _openGithub(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.t('linkOpenFailed'))),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final controller = ref.read(appSettingsProvider.notifier);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(l10n.t('settingsTitle')),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionHeader(l10n.t('languageLabel')),
          const SizedBox(height: 10),
          _LanguageSwitch(
            current: settings.language,
            onChanged: controller.setLanguage,
          ),
          const SizedBox(height: 28),
          _SectionHeader(l10n.t('generalLabel')),
          _SettingsCard(
            children: [
              SwitchListTile(
                value: settings.soundEnabled,
                onChanged: controller.setSound,
                title: Text(l10n.t('soundEnabledLabel'),
                    style: const TextStyle(color: Colors.white)),
                activeThumbColor: Colors.greenAccent,
              ),
              const Divider(color: Colors.white12, height: 1),
              SwitchListTile(
                value: settings.redact,
                onChanged: controller.setRedact,
                title: Text(l10n.t('redactLabel'),
                    style: const TextStyle(color: Colors.white)),
                activeThumbColor: Colors.greenAccent,
              ),
            ],
          ),
          const SizedBox(height: 28),
          _SectionHeader(l10n.t('developersTitle')),
          const SizedBox(height: 10),
          ..._developers.map(
            (dev) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _DeveloperTile(
                developer: dev,
                onTap: () => _openGithub(context, dev.githubUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, left: 4, right: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

class _LanguageSwitch extends StatelessWidget {
  final AppLanguage current;
  final ValueChanged<AppLanguage> onChanged;

  const _LanguageSwitch({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: AppLanguage.values.map((lang) {
          final selected = lang == current;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(lang),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: selected ? Colors.greenAccent : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  lang.nativeName,
                  style: TextStyle(
                    color: selected ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DeveloperTile extends StatelessWidget {
  final _Developer developer;
  final VoidCallback onTap;

  const _DeveloperTile({required this.developer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.greenAccent.withValues(alpha: 0.15),
                child: Text(
                  developer.name.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(developer.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(developer.handle,
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new, color: Colors.white24, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
