import '../entities/tracker_snapshot.dart';
import '../repositories/ble_repository.dart';

class TrackDeviceUseCase {
  final BleRepository repository;

  const TrackDeviceUseCase(this.repository);

  Stream<TrackerSnapshot> call({String? targetName}) {
    return repository.trackerStream(targetName: targetName);
  }
}
