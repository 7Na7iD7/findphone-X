import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/tracker_snapshot.dart';
import 'core_providers.dart';

final trackerSnapshotProvider =
    StreamProvider.autoDispose.family<TrackerSnapshot, String?>((ref, targetName) {
  final useCase = ref.watch(trackDeviceUseCaseProvider);
  ref.onDispose(() {
    ref.read(bleRepositoryProvider).stopTracking();
  });
  return useCase(targetName: targetName);
});
