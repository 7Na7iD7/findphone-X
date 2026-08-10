import '../repositories/ble_repository.dart';

class GetPairedDevicesUseCase {
  final BleRepository repository;

  const GetPairedDevicesUseCase(this.repository);

  Future<List<PairedDeviceInfo>> call() => repository.pairedDevices();
}
