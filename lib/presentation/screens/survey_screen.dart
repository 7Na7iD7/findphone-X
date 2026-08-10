import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/tracker_providers.dart';
import '../../application/providers/settings_provider.dart';
import '../../domain/entities/proximity.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/signal_bar.dart';
import '../widgets/tone.dart';

class SurveyScreen extends ConsumerWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshotAsync = ref.watch(trackerSnapshotProvider(null));
    final redact = ref.watch(appSettingsProvider).redact;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(l10n.t('surveyTitle')),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: snapshotAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.greenAccent),
        ),
        error: (err, st) => Center(
          child: Text(l10n.tp('errorPrefix', {'error': '$err'}),
              style: const TextStyle(color: Colors.white70)),
        ),
        data: (data) {
          if (data.radioIssue != null) {
            return Center(
              child: Text(
                data.radioIssue!,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            );
          }
          final devices = data.sortedAdvertisers;
          if (devices.isEmpty) {
            return Center(
              child: Text(
                l10n.t('surveyEmpty'),
                style: const TextStyle(color: Colors.white38),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: devices.length,
            separatorBuilder: (_, __) => const Divider(color: Colors.white12),
            itemBuilder: (context, i) {
              final a = devices[i];
              final live = a.smoothed.round();
              final tone = toneForRssi(live);
              final stale = DateTime.now().difference(a.last) >
                  const Duration(seconds: 3);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${i + 1}.',
                            style: const TextStyle(color: Colors.white38)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            redact ? l10n.t('unknownDevice') : a.label,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '$live dBm${stale ? l10n.t('staleSuffix') : ""}',
                          style: TextStyle(
                              color: tone, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    SignalBar(rssi: live, color: tone),
                    const SizedBox(height: 4),
                    Text(
                      Proximity.describe(live),
                      style: TextStyle(
                          color: tone.withValues(alpha: 0.8), fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
