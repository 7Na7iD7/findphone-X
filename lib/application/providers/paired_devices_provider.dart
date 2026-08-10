import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/ble_repository.dart';
import 'core_providers.dart';

final pairedDevicesProvider =
    FutureProvider.autoDispose<List<PairedDeviceInfo>>((ref) {
  final useCase = ref.watch(getPairedDevicesUseCaseProvider);
  return useCase();
});
