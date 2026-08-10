import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Devices extends Table {
  TextColumn get key => text()();
  TextColumn get label => text()();
  DateTimeColumn get lastSeen => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

class SignalReadings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get deviceKey => text()();
  IntColumn get rssi => integer()();
  RealColumn get distanceMeters => real().nullable()();
  TextColumn get source => text()();
  DateTimeColumn get at => dateTime()();
}

@DriftDatabase(tables: [Devices, SignalReadings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  Future<void> upsertDevice(String key, String label, DateTime lastSeen) {
    return into(devices).insertOnConflictUpdate(
      DevicesCompanion.insert(key: key, label: label, lastSeen: lastSeen),
    );
  }

  Future<void> insertReading(SignalReadingsCompanion reading) {
    return into(signalReadings).insert(reading);
  }

  Future<List<SignalReading>> readingsSince(String deviceKey, DateTime cutoff) {
    return (select(signalReadings)
          ..where((r) => r.deviceKey.equals(deviceKey) & r.at.isBiggerOrEqualValue(cutoff))
          ..orderBy([(r) => OrderingTerm.asc(r.at)]))
        .get();
  }

  Future<int> deleteOlderThan(DateTime cutoff) {
    return (delete(signalReadings)..where((r) => r.at.isSmallerThanValue(cutoff))).go();
  }

  Future<List<Device>> recentDevices(int limit) {
    return (select(devices)
          ..orderBy([(d) => OrderingTerm.desc(d.lastSeen)])
          ..limit(limit))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'findphone.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
