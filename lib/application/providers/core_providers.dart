import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/app_database.dart';
import '../../data/repositories/ble_repository_impl.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/repositories/ble_repository.dart';
import '../../domain/repositories/history_repository.dart';
import '../../domain/usecases/analyze_signal_usecase.dart';
import '../../domain/usecases/get_paired_devices_usecase.dart';
import '../../domain/usecases/track_device_usecase.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(ref.watch(appDatabaseProvider));
});

final bleRepositoryProvider = Provider<BleRepositoryImpl>((ref) {
  final repo = BleRepositoryImpl(
    historyRepository: ref.watch(historyRepositoryProvider),
  );
  ref.onDispose(repo.dispose);
  return repo;
});

final bleRepositoryAbstractProvider = Provider<BleRepository>((ref) {
  return ref.watch(bleRepositoryProvider);
});

final trackDeviceUseCaseProvider = Provider<TrackDeviceUseCase>((ref) {
  return TrackDeviceUseCase(ref.watch(bleRepositoryAbstractProvider));
});

final getPairedDevicesUseCaseProvider = Provider<GetPairedDevicesUseCase>((ref) {
  return GetPairedDevicesUseCase(ref.watch(bleRepositoryAbstractProvider));
});

final analyzeSignalUseCaseProvider = Provider<AnalyzeSignalUseCase>((ref) {
  return const AnalyzeSignalUseCase();
});
