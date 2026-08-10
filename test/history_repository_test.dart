import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:findphonex/data/local/app_database.dart';
import 'package:findphonex/data/repositories/history_repository_impl.dart';
import 'package:findphonex/domain/entities/reading.dart';

void main() {
  late AppDatabase db;
  late HistoryRepositoryImpl repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = HistoryRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('recordReading stores a reading retrievable by device key', () async {
    final reading = Reading(rssi: -60, at: DateTime.now(), source: 'advert');
    await repo.recordReading(deviceKey: 'abc', deviceLabel: 'iPhone', reading: reading);

    final stored = await repo.readingsFor('abc');
    expect(stored.length, 1);
    expect(stored.first.rssi, -60);
  });

  test('readingsFor respects the within duration filter', () async {
    final old = Reading(
      rssi: -70,
      at: DateTime.now().subtract(const Duration(hours: 2)),
      source: 'advert',
    );
    final recent = Reading(rssi: -55, at: DateTime.now(), source: 'advert');

    await repo.recordReading(deviceKey: 'abc', deviceLabel: 'iPhone', reading: old);
    await repo.recordReading(deviceKey: 'abc', deviceLabel: 'iPhone', reading: recent);

    final filtered = await repo.readingsFor('abc', within: const Duration(minutes: 30));
    expect(filtered.length, 1);
    expect(filtered.first.rssi, -55);
  });

  test('pruneOlderThan removes stale readings', () async {
    final old = Reading(
      rssi: -70,
      at: DateTime.now().subtract(const Duration(days: 2)),
      source: 'advert',
    );
    await repo.recordReading(deviceKey: 'abc', deviceLabel: 'iPhone', reading: old);
    await repo.pruneOlderThan(const Duration(days: 1));

    final remaining = await repo.readingsFor('abc');
    expect(remaining, isEmpty);
  });
}
