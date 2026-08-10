// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DevicesTable extends Devices with TableInfo<$DevicesTable, Device> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastSeenMeta =
      const VerificationMeta('lastSeen');
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
      'last_seen', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, label, lastSeen];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(Insertable<Device> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('last_seen')) {
      context.handle(_lastSeenMeta,
          lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta));
    } else if (isInserting) {
      context.missing(_lastSeenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Device map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Device(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      lastSeen: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_seen'])!,
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

class Device extends DataClass implements Insertable<Device> {
  final String key;
  final String label;
  final DateTime lastSeen;
  const Device(
      {required this.key, required this.label, required this.lastSeen});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['label'] = Variable<String>(label);
    map['last_seen'] = Variable<DateTime>(lastSeen);
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      key: Value(key),
      label: Value(label),
      lastSeen: Value(lastSeen),
    );
  }

  factory Device.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Device(
      key: serializer.fromJson<String>(json['key']),
      label: serializer.fromJson<String>(json['label']),
      lastSeen: serializer.fromJson<DateTime>(json['lastSeen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'label': serializer.toJson<String>(label),
      'lastSeen': serializer.toJson<DateTime>(lastSeen),
    };
  }

  Device copyWith({String? key, String? label, DateTime? lastSeen}) => Device(
        key: key ?? this.key,
        label: label ?? this.label,
        lastSeen: lastSeen ?? this.lastSeen,
      );
  Device copyWithCompanion(DevicesCompanion data) {
    return Device(
      key: data.key.present ? data.key.value : this.key,
      label: data.label.present ? data.label.value : this.label,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Device(')
          ..write('key: $key, ')
          ..write('label: $label, ')
          ..write('lastSeen: $lastSeen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, label, lastSeen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device &&
          other.key == this.key &&
          other.label == this.label &&
          other.lastSeen == this.lastSeen);
}

class DevicesCompanion extends UpdateCompanion<Device> {
  final Value<String> key;
  final Value<String> label;
  final Value<DateTime> lastSeen;
  final Value<int> rowid;
  const DevicesCompanion({
    this.key = const Value.absent(),
    this.label = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesCompanion.insert({
    required String key,
    required String label,
    required DateTime lastSeen,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        label = Value(label),
        lastSeen = Value(lastSeen);
  static Insertable<Device> custom({
    Expression<String>? key,
    Expression<String>? label,
    Expression<DateTime>? lastSeen,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (label != null) 'label': label,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesCompanion copyWith(
      {Value<String>? key,
      Value<String>? label,
      Value<DateTime>? lastSeen,
      Value<int>? rowid}) {
    return DevicesCompanion(
      key: key ?? this.key,
      label: label ?? this.label,
      lastSeen: lastSeen ?? this.lastSeen,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('key: $key, ')
          ..write('label: $label, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SignalReadingsTable extends SignalReadings
    with TableInfo<$SignalReadingsTable, SignalReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SignalReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _deviceKeyMeta =
      const VerificationMeta('deviceKey');
  @override
  late final GeneratedColumn<String> deviceKey = GeneratedColumn<String>(
      'device_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rssiMeta = const VerificationMeta('rssi');
  @override
  late final GeneratedColumn<int> rssi = GeneratedColumn<int>(
      'rssi', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _distanceMetersMeta =
      const VerificationMeta('distanceMeters');
  @override
  late final GeneratedColumn<double> distanceMeters = GeneratedColumn<double>(
      'distance_meters', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
      'at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, deviceKey, rssi, distanceMeters, source, at];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'signal_readings';
  @override
  VerificationContext validateIntegrity(Insertable<SignalReading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('device_key')) {
      context.handle(_deviceKeyMeta,
          deviceKey.isAcceptableOrUnknown(data['device_key']!, _deviceKeyMeta));
    } else if (isInserting) {
      context.missing(_deviceKeyMeta);
    }
    if (data.containsKey('rssi')) {
      context.handle(
          _rssiMeta, rssi.isAcceptableOrUnknown(data['rssi']!, _rssiMeta));
    } else if (isInserting) {
      context.missing(_rssiMeta);
    }
    if (data.containsKey('distance_meters')) {
      context.handle(
          _distanceMetersMeta,
          distanceMeters.isAcceptableOrUnknown(
              data['distance_meters']!, _distanceMetersMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SignalReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SignalReading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      deviceKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_key'])!,
      rssi: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rssi'])!,
      distanceMeters: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}distance_meters']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      at: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}at'])!,
    );
  }

  @override
  $SignalReadingsTable createAlias(String alias) {
    return $SignalReadingsTable(attachedDatabase, alias);
  }
}

class SignalReading extends DataClass implements Insertable<SignalReading> {
  final int id;
  final String deviceKey;
  final int rssi;
  final double? distanceMeters;
  final String source;
  final DateTime at;
  const SignalReading(
      {required this.id,
      required this.deviceKey,
      required this.rssi,
      this.distanceMeters,
      required this.source,
      required this.at});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['device_key'] = Variable<String>(deviceKey);
    map['rssi'] = Variable<int>(rssi);
    if (!nullToAbsent || distanceMeters != null) {
      map['distance_meters'] = Variable<double>(distanceMeters);
    }
    map['source'] = Variable<String>(source);
    map['at'] = Variable<DateTime>(at);
    return map;
  }

  SignalReadingsCompanion toCompanion(bool nullToAbsent) {
    return SignalReadingsCompanion(
      id: Value(id),
      deviceKey: Value(deviceKey),
      rssi: Value(rssi),
      distanceMeters: distanceMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceMeters),
      source: Value(source),
      at: Value(at),
    );
  }

  factory SignalReading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SignalReading(
      id: serializer.fromJson<int>(json['id']),
      deviceKey: serializer.fromJson<String>(json['deviceKey']),
      rssi: serializer.fromJson<int>(json['rssi']),
      distanceMeters: serializer.fromJson<double?>(json['distanceMeters']),
      source: serializer.fromJson<String>(json['source']),
      at: serializer.fromJson<DateTime>(json['at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deviceKey': serializer.toJson<String>(deviceKey),
      'rssi': serializer.toJson<int>(rssi),
      'distanceMeters': serializer.toJson<double?>(distanceMeters),
      'source': serializer.toJson<String>(source),
      'at': serializer.toJson<DateTime>(at),
    };
  }

  SignalReading copyWith(
          {int? id,
          String? deviceKey,
          int? rssi,
          Value<double?> distanceMeters = const Value.absent(),
          String? source,
          DateTime? at}) =>
      SignalReading(
        id: id ?? this.id,
        deviceKey: deviceKey ?? this.deviceKey,
        rssi: rssi ?? this.rssi,
        distanceMeters:
            distanceMeters.present ? distanceMeters.value : this.distanceMeters,
        source: source ?? this.source,
        at: at ?? this.at,
      );
  SignalReading copyWithCompanion(SignalReadingsCompanion data) {
    return SignalReading(
      id: data.id.present ? data.id.value : this.id,
      deviceKey: data.deviceKey.present ? data.deviceKey.value : this.deviceKey,
      rssi: data.rssi.present ? data.rssi.value : this.rssi,
      distanceMeters: data.distanceMeters.present
          ? data.distanceMeters.value
          : this.distanceMeters,
      source: data.source.present ? data.source.value : this.source,
      at: data.at.present ? data.at.value : this.at,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SignalReading(')
          ..write('id: $id, ')
          ..write('deviceKey: $deviceKey, ')
          ..write('rssi: $rssi, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('source: $source, ')
          ..write('at: $at')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, deviceKey, rssi, distanceMeters, source, at);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignalReading &&
          other.id == this.id &&
          other.deviceKey == this.deviceKey &&
          other.rssi == this.rssi &&
          other.distanceMeters == this.distanceMeters &&
          other.source == this.source &&
          other.at == this.at);
}

class SignalReadingsCompanion extends UpdateCompanion<SignalReading> {
  final Value<int> id;
  final Value<String> deviceKey;
  final Value<int> rssi;
  final Value<double?> distanceMeters;
  final Value<String> source;
  final Value<DateTime> at;
  const SignalReadingsCompanion({
    this.id = const Value.absent(),
    this.deviceKey = const Value.absent(),
    this.rssi = const Value.absent(),
    this.distanceMeters = const Value.absent(),
    this.source = const Value.absent(),
    this.at = const Value.absent(),
  });
  SignalReadingsCompanion.insert({
    this.id = const Value.absent(),
    required String deviceKey,
    required int rssi,
    this.distanceMeters = const Value.absent(),
    required String source,
    required DateTime at,
  })  : deviceKey = Value(deviceKey),
        rssi = Value(rssi),
        source = Value(source),
        at = Value(at);
  static Insertable<SignalReading> custom({
    Expression<int>? id,
    Expression<String>? deviceKey,
    Expression<int>? rssi,
    Expression<double>? distanceMeters,
    Expression<String>? source,
    Expression<DateTime>? at,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceKey != null) 'device_key': deviceKey,
      if (rssi != null) 'rssi': rssi,
      if (distanceMeters != null) 'distance_meters': distanceMeters,
      if (source != null) 'source': source,
      if (at != null) 'at': at,
    });
  }

  SignalReadingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? deviceKey,
      Value<int>? rssi,
      Value<double?>? distanceMeters,
      Value<String>? source,
      Value<DateTime>? at}) {
    return SignalReadingsCompanion(
      id: id ?? this.id,
      deviceKey: deviceKey ?? this.deviceKey,
      rssi: rssi ?? this.rssi,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      source: source ?? this.source,
      at: at ?? this.at,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deviceKey.present) {
      map['device_key'] = Variable<String>(deviceKey.value);
    }
    if (rssi.present) {
      map['rssi'] = Variable<int>(rssi.value);
    }
    if (distanceMeters.present) {
      map['distance_meters'] = Variable<double>(distanceMeters.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SignalReadingsCompanion(')
          ..write('id: $id, ')
          ..write('deviceKey: $deviceKey, ')
          ..write('rssi: $rssi, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('source: $source, ')
          ..write('at: $at')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DevicesTable devices = $DevicesTable(this);
  late final $SignalReadingsTable signalReadings = $SignalReadingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [devices, signalReadings];
}

typedef $$DevicesTableCreateCompanionBuilder = DevicesCompanion Function({
  required String key,
  required String label,
  required DateTime lastSeen,
  Value<int> rowid,
});
typedef $$DevicesTableUpdateCompanionBuilder = DevicesCompanion Function({
  Value<String> key,
  Value<String> label,
  Value<DateTime> lastSeen,
  Value<int> rowid,
});

class $$DevicesTableFilterComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
      column: $table.lastSeen, builder: (column) => ColumnFilters(column));
}

class $$DevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
      column: $table.lastSeen, builder: (column) => ColumnOrderings(column));
}

class $$DevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);
}

class $$DevicesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DevicesTable,
    Device,
    $$DevicesTableFilterComposer,
    $$DevicesTableOrderingComposer,
    $$DevicesTableAnnotationComposer,
    $$DevicesTableCreateCompanionBuilder,
    $$DevicesTableUpdateCompanionBuilder,
    (Device, BaseReferences<_$AppDatabase, $DevicesTable, Device>),
    Device,
    PrefetchHooks Function()> {
  $$DevicesTableTableManager(_$AppDatabase db, $DevicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<DateTime> lastSeen = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DevicesCompanion(
            key: key,
            label: label,
            lastSeen: lastSeen,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String label,
            required DateTime lastSeen,
            Value<int> rowid = const Value.absent(),
          }) =>
              DevicesCompanion.insert(
            key: key,
            label: label,
            lastSeen: lastSeen,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DevicesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DevicesTable,
    Device,
    $$DevicesTableFilterComposer,
    $$DevicesTableOrderingComposer,
    $$DevicesTableAnnotationComposer,
    $$DevicesTableCreateCompanionBuilder,
    $$DevicesTableUpdateCompanionBuilder,
    (Device, BaseReferences<_$AppDatabase, $DevicesTable, Device>),
    Device,
    PrefetchHooks Function()>;
typedef $$SignalReadingsTableCreateCompanionBuilder = SignalReadingsCompanion
    Function({
  Value<int> id,
  required String deviceKey,
  required int rssi,
  Value<double?> distanceMeters,
  required String source,
  required DateTime at,
});
typedef $$SignalReadingsTableUpdateCompanionBuilder = SignalReadingsCompanion
    Function({
  Value<int> id,
  Value<String> deviceKey,
  Value<int> rssi,
  Value<double?> distanceMeters,
  Value<String> source,
  Value<DateTime> at,
});

class $$SignalReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $SignalReadingsTable> {
  $$SignalReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceKey => $composableBuilder(
      column: $table.deviceKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rssi => $composableBuilder(
      column: $table.rssi, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get distanceMeters => $composableBuilder(
      column: $table.distanceMeters,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get at => $composableBuilder(
      column: $table.at, builder: (column) => ColumnFilters(column));
}

class $$SignalReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SignalReadingsTable> {
  $$SignalReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceKey => $composableBuilder(
      column: $table.deviceKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rssi => $composableBuilder(
      column: $table.rssi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get distanceMeters => $composableBuilder(
      column: $table.distanceMeters,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get at => $composableBuilder(
      column: $table.at, builder: (column) => ColumnOrderings(column));
}

class $$SignalReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SignalReadingsTable> {
  $$SignalReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceKey =>
      $composableBuilder(column: $table.deviceKey, builder: (column) => column);

  GeneratedColumn<int> get rssi =>
      $composableBuilder(column: $table.rssi, builder: (column) => column);

  GeneratedColumn<double> get distanceMeters => $composableBuilder(
      column: $table.distanceMeters, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);
}

class $$SignalReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SignalReadingsTable,
    SignalReading,
    $$SignalReadingsTableFilterComposer,
    $$SignalReadingsTableOrderingComposer,
    $$SignalReadingsTableAnnotationComposer,
    $$SignalReadingsTableCreateCompanionBuilder,
    $$SignalReadingsTableUpdateCompanionBuilder,
    (
      SignalReading,
      BaseReferences<_$AppDatabase, $SignalReadingsTable, SignalReading>
    ),
    SignalReading,
    PrefetchHooks Function()> {
  $$SignalReadingsTableTableManager(
      _$AppDatabase db, $SignalReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SignalReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SignalReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SignalReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> deviceKey = const Value.absent(),
            Value<int> rssi = const Value.absent(),
            Value<double?> distanceMeters = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<DateTime> at = const Value.absent(),
          }) =>
              SignalReadingsCompanion(
            id: id,
            deviceKey: deviceKey,
            rssi: rssi,
            distanceMeters: distanceMeters,
            source: source,
            at: at,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String deviceKey,
            required int rssi,
            Value<double?> distanceMeters = const Value.absent(),
            required String source,
            required DateTime at,
          }) =>
              SignalReadingsCompanion.insert(
            id: id,
            deviceKey: deviceKey,
            rssi: rssi,
            distanceMeters: distanceMeters,
            source: source,
            at: at,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SignalReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SignalReadingsTable,
    SignalReading,
    $$SignalReadingsTableFilterComposer,
    $$SignalReadingsTableOrderingComposer,
    $$SignalReadingsTableAnnotationComposer,
    $$SignalReadingsTableCreateCompanionBuilder,
    $$SignalReadingsTableUpdateCompanionBuilder,
    (
      SignalReading,
      BaseReferences<_$AppDatabase, $SignalReadingsTable, SignalReading>
    ),
    SignalReading,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
  $$SignalReadingsTableTableManager get signalReadings =>
      $$SignalReadingsTableTableManager(_db, _db.signalReadings);
}
