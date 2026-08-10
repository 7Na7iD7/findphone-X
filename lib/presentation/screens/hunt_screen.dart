import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/tracker_providers.dart';
import '../../application/providers/settings_provider.dart';
import '../../application/providers/clicker_provider.dart';
import '../../application/providers/core_providers.dart';
import '../../domain/entities/proximity.dart';
import '../../domain/entities/reading.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/big_number.dart';
import '../widgets/signal_bar.dart';
import '../widgets/sparkline.dart';
import '../widgets/tone.dart';

class HuntScreen extends ConsumerStatefulWidget {
  final String targetName;

  const HuntScreen({super.key, required this.targetName});

  @override
  ConsumerState<HuntScreen> createState() => _HuntScreenState();
}

class _HuntScreenState extends ConsumerState<HuntScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final soundEnabled = ref.read(appSettingsProvider).soundEnabled;
      if (soundEnabled) {
        ref.read(clickerControllerProvider.notifier).enable();
      }
    });
  }

  @override
  void dispose() {
    ref.read(clickerControllerProvider.notifier).disable();
    super.dispose();
  }

  Widget _trendChip(Trend trend, AppLocalizations l10n) {
    switch (trend) {
      case Trend.warmer:
        return Text(l10n.t('trendWarmer'),
            style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold));
      case Trend.colder:
        return Text(l10n.t('trendColder'),
            style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold));
      case Trend.steady:
        return Text(l10n.t('trendSteady'), style: const TextStyle(color: Colors.white38));
      case Trend.unknown:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final snapshotAsync = ref.watch(trackerSnapshotProvider(widget.targetName));
    final analyzeUseCase = ref.watch(analyzeSignalUseCaseProvider);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.targetName),
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

          final live = data.live;
          if (live == null) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bluetooth_searching, color: Colors.white24, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    l10n.tp('noSignalYet', {'count': '${data.advertisers.length}'}),
                    style: const TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.t('noSignalHint'),
                    style: const TextStyle(color: Colors.white24, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          ref.read(clickerControllerProvider.notifier).update(data.isFresh ? live : null);

          final tone = toneForRssi(live);
          final trend = analyzeUseCase.trendOf(data.readings, data.at);
          final lastMinute = data.readings.since(const Duration(seconds: 60), data.at);
          final peak = lastMinute.peakRssi ?? live;
          final distance = analyzeUseCase.estimateDistanceMeters(live);
          final stale = data.readings.isNotEmpty &&
              data.at.difference(data.readings.last.at) > const Duration(seconds: 15);

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 12),
                BigNumber(value: live, color: tone),
                const SizedBox(height: 4),
                Text(
                  l10n.tp('distanceApprox', {'distance': distance.toStringAsFixed(1)}),
                  style: TextStyle(color: tone.withValues(alpha: 0.7), fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  Proximity.describe(live),
                  style: TextStyle(color: tone, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
                const SizedBox(height: 8),
                _trendChip(trend, l10n),
                const SizedBox(height: 24),
                SignalBar(rssi: live, color: tone, height: 20),
                const SizedBox(height: 24),
                Sparkline(
                  readings: data.readings.length > 44
                      ? data.readings.sublist(data.readings.length - 44)
                      : data.readings,
                  color: tone,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.tp('statsLine', {
                    'count': '${lastMinute.length}',
                    'total': '${data.readings.length}',
                  }),
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                Text(
                  l10n.tp('peakLine', {'peak': '$peak'}),
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                if (stale)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      l10n.t('staleWarning'),
                      style: const TextStyle(color: Colors.orangeAccent, fontSize: 12),
                    ),
                  ),
                const Spacer(),
                Text(
                  l10n.t('moveHint'),
                  style: const TextStyle(color: Colors.white24, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
