// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $BirthdaysTable extends Birthdays
    with TableInfo<$BirthdaysTable, Birthday> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BirthdaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _customMessageMeta = const VerificationMeta(
    'customMessage',
  );
  @override
  late final GeneratedColumn<String> customMessage = GeneratedColumn<String>(
    'custom_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int> day = GeneratedColumn<int>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notificationHourMeta = const VerificationMeta(
    'notificationHour',
  );
  @override
  late final GeneratedColumn<int> notificationHour = GeneratedColumn<int>(
    'notification_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(9),
  );
  static const VerificationMeta _notificationMinuteMeta =
      const VerificationMeta('notificationMinute');
  @override
  late final GeneratedColumn<int> notificationMinute = GeneratedColumn<int>(
    'notification_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notificationScheduledMeta =
      const VerificationMeta('notificationScheduled');
  @override
  late final GeneratedColumn<bool> notificationScheduled =
      GeneratedColumn<bool>(
        'notification_scheduled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notification_scheduled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<Uint8List> photo = GeneratedColumn<Uint8List>(
    'photo',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    customMessage,
    day,
    id,
    month,
    name,
    note,
    notificationHour,
    notificationMinute,
    notificationScheduled,
    phone,
    photo,
    year,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'birthdays';
  @override
  VerificationContext validateIntegrity(
    Insertable<Birthday> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('custom_message')) {
      context.handle(
        _customMessageMeta,
        customMessage.isAcceptableOrUnknown(
          data['custom_message']!,
          _customMessageMeta,
        ),
      );
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('notification_hour')) {
      context.handle(
        _notificationHourMeta,
        notificationHour.isAcceptableOrUnknown(
          data['notification_hour']!,
          _notificationHourMeta,
        ),
      );
    }
    if (data.containsKey('notification_minute')) {
      context.handle(
        _notificationMinuteMeta,
        notificationMinute.isAcceptableOrUnknown(
          data['notification_minute']!,
          _notificationMinuteMeta,
        ),
      );
    }
    if (data.containsKey('notification_scheduled')) {
      context.handle(
        _notificationScheduledMeta,
        notificationScheduled.isAcceptableOrUnknown(
          data['notification_scheduled']!,
          _notificationScheduledMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(
        _photoMeta,
        photo.isAcceptableOrUnknown(data['photo']!, _photoMeta),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Birthday map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Birthday(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      customMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_message'],
      ),
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      notificationHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_hour'],
      )!,
      notificationMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_minute'],
      )!,
      notificationScheduled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notification_scheduled'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      photo: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}photo'],
      ),
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      ),
    );
  }

  @override
  $BirthdaysTable createAlias(String alias) {
    return $BirthdaysTable(attachedDatabase, alias);
  }
}

class Birthday extends DataClass implements Insertable<Birthday> {
  final DateTime createdAt;
  final String? customMessage;
  final int day;
  final int id;
  final int month;
  final String name;
  final String? note;
  final int notificationHour;
  final int notificationMinute;
  final bool notificationScheduled;
  final String phone;
  final Uint8List? photo;
  final int? year;
  const Birthday({
    required this.createdAt,
    this.customMessage,
    required this.day,
    required this.id,
    required this.month,
    required this.name,
    this.note,
    required this.notificationHour,
    required this.notificationMinute,
    required this.notificationScheduled,
    required this.phone,
    this.photo,
    this.year,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || customMessage != null) {
      map['custom_message'] = Variable<String>(customMessage);
    }
    map['day'] = Variable<int>(day);
    map['id'] = Variable<int>(id);
    map['month'] = Variable<int>(month);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['notification_hour'] = Variable<int>(notificationHour);
    map['notification_minute'] = Variable<int>(notificationMinute);
    map['notification_scheduled'] = Variable<bool>(notificationScheduled);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<Uint8List>(photo);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    return map;
  }

  BirthdaysCompanion toCompanion(bool nullToAbsent) {
    return BirthdaysCompanion(
      createdAt: Value(createdAt),
      customMessage: customMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(customMessage),
      day: Value(day),
      id: Value(id),
      month: Value(month),
      name: Value(name),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      notificationHour: Value(notificationHour),
      notificationMinute: Value(notificationMinute),
      notificationScheduled: Value(notificationScheduled),
      phone: Value(phone),
      photo: photo == null && nullToAbsent
          ? const Value.absent()
          : Value(photo),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
    );
  }

  factory Birthday.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Birthday(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      customMessage: serializer.fromJson<String?>(json['customMessage']),
      day: serializer.fromJson<int>(json['day']),
      id: serializer.fromJson<int>(json['id']),
      month: serializer.fromJson<int>(json['month']),
      name: serializer.fromJson<String>(json['name']),
      note: serializer.fromJson<String?>(json['note']),
      notificationHour: serializer.fromJson<int>(json['notificationHour']),
      notificationMinute: serializer.fromJson<int>(json['notificationMinute']),
      notificationScheduled: serializer.fromJson<bool>(
        json['notificationScheduled'],
      ),
      phone: serializer.fromJson<String>(json['phone']),
      photo: serializer.fromJson<Uint8List?>(json['photo']),
      year: serializer.fromJson<int?>(json['year']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'customMessage': serializer.toJson<String?>(customMessage),
      'day': serializer.toJson<int>(day),
      'id': serializer.toJson<int>(id),
      'month': serializer.toJson<int>(month),
      'name': serializer.toJson<String>(name),
      'note': serializer.toJson<String?>(note),
      'notificationHour': serializer.toJson<int>(notificationHour),
      'notificationMinute': serializer.toJson<int>(notificationMinute),
      'notificationScheduled': serializer.toJson<bool>(notificationScheduled),
      'phone': serializer.toJson<String>(phone),
      'photo': serializer.toJson<Uint8List?>(photo),
      'year': serializer.toJson<int?>(year),
    };
  }

  Birthday copyWith({
    DateTime? createdAt,
    Value<String?> customMessage = const Value.absent(),
    int? day,
    int? id,
    int? month,
    String? name,
    Value<String?> note = const Value.absent(),
    int? notificationHour,
    int? notificationMinute,
    bool? notificationScheduled,
    String? phone,
    Value<Uint8List?> photo = const Value.absent(),
    Value<int?> year = const Value.absent(),
  }) => Birthday(
    createdAt: createdAt ?? this.createdAt,
    customMessage: customMessage.present
        ? customMessage.value
        : this.customMessage,
    day: day ?? this.day,
    id: id ?? this.id,
    month: month ?? this.month,
    name: name ?? this.name,
    note: note.present ? note.value : this.note,
    notificationHour: notificationHour ?? this.notificationHour,
    notificationMinute: notificationMinute ?? this.notificationMinute,
    notificationScheduled: notificationScheduled ?? this.notificationScheduled,
    phone: phone ?? this.phone,
    photo: photo.present ? photo.value : this.photo,
    year: year.present ? year.value : this.year,
  );
  Birthday copyWithCompanion(BirthdaysCompanion data) {
    return Birthday(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      customMessage: data.customMessage.present
          ? data.customMessage.value
          : this.customMessage,
      day: data.day.present ? data.day.value : this.day,
      id: data.id.present ? data.id.value : this.id,
      month: data.month.present ? data.month.value : this.month,
      name: data.name.present ? data.name.value : this.name,
      note: data.note.present ? data.note.value : this.note,
      notificationHour: data.notificationHour.present
          ? data.notificationHour.value
          : this.notificationHour,
      notificationMinute: data.notificationMinute.present
          ? data.notificationMinute.value
          : this.notificationMinute,
      notificationScheduled: data.notificationScheduled.present
          ? data.notificationScheduled.value
          : this.notificationScheduled,
      phone: data.phone.present ? data.phone.value : this.phone,
      photo: data.photo.present ? data.photo.value : this.photo,
      year: data.year.present ? data.year.value : this.year,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Birthday(')
          ..write('createdAt: $createdAt, ')
          ..write('customMessage: $customMessage, ')
          ..write('day: $day, ')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('name: $name, ')
          ..write('note: $note, ')
          ..write('notificationHour: $notificationHour, ')
          ..write('notificationMinute: $notificationMinute, ')
          ..write('notificationScheduled: $notificationScheduled, ')
          ..write('phone: $phone, ')
          ..write('photo: $photo, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    customMessage,
    day,
    id,
    month,
    name,
    note,
    notificationHour,
    notificationMinute,
    notificationScheduled,
    phone,
    $driftBlobEquality.hash(photo),
    year,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Birthday &&
          other.createdAt == this.createdAt &&
          other.customMessage == this.customMessage &&
          other.day == this.day &&
          other.id == this.id &&
          other.month == this.month &&
          other.name == this.name &&
          other.note == this.note &&
          other.notificationHour == this.notificationHour &&
          other.notificationMinute == this.notificationMinute &&
          other.notificationScheduled == this.notificationScheduled &&
          other.phone == this.phone &&
          $driftBlobEquality.equals(other.photo, this.photo) &&
          other.year == this.year);
}

class BirthdaysCompanion extends UpdateCompanion<Birthday> {
  final Value<DateTime> createdAt;
  final Value<String?> customMessage;
  final Value<int> day;
  final Value<int> id;
  final Value<int> month;
  final Value<String> name;
  final Value<String?> note;
  final Value<int> notificationHour;
  final Value<int> notificationMinute;
  final Value<bool> notificationScheduled;
  final Value<String> phone;
  final Value<Uint8List?> photo;
  final Value<int?> year;
  const BirthdaysCompanion({
    this.createdAt = const Value.absent(),
    this.customMessage = const Value.absent(),
    this.day = const Value.absent(),
    this.id = const Value.absent(),
    this.month = const Value.absent(),
    this.name = const Value.absent(),
    this.note = const Value.absent(),
    this.notificationHour = const Value.absent(),
    this.notificationMinute = const Value.absent(),
    this.notificationScheduled = const Value.absent(),
    this.phone = const Value.absent(),
    this.photo = const Value.absent(),
    this.year = const Value.absent(),
  });
  BirthdaysCompanion.insert({
    this.createdAt = const Value.absent(),
    this.customMessage = const Value.absent(),
    required int day,
    this.id = const Value.absent(),
    required int month,
    required String name,
    this.note = const Value.absent(),
    this.notificationHour = const Value.absent(),
    this.notificationMinute = const Value.absent(),
    this.notificationScheduled = const Value.absent(),
    required String phone,
    this.photo = const Value.absent(),
    this.year = const Value.absent(),
  }) : day = Value(day),
       month = Value(month),
       name = Value(name),
       phone = Value(phone);
  static Insertable<Birthday> custom({
    Expression<DateTime>? createdAt,
    Expression<String>? customMessage,
    Expression<int>? day,
    Expression<int>? id,
    Expression<int>? month,
    Expression<String>? name,
    Expression<String>? note,
    Expression<int>? notificationHour,
    Expression<int>? notificationMinute,
    Expression<bool>? notificationScheduled,
    Expression<String>? phone,
    Expression<Uint8List>? photo,
    Expression<int>? year,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (customMessage != null) 'custom_message': customMessage,
      if (day != null) 'day': day,
      if (id != null) 'id': id,
      if (month != null) 'month': month,
      if (name != null) 'name': name,
      if (note != null) 'note': note,
      if (notificationHour != null) 'notification_hour': notificationHour,
      if (notificationMinute != null) 'notification_minute': notificationMinute,
      if (notificationScheduled != null)
        'notification_scheduled': notificationScheduled,
      if (phone != null) 'phone': phone,
      if (photo != null) 'photo': photo,
      if (year != null) 'year': year,
    });
  }

  BirthdaysCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<String?>? customMessage,
    Value<int>? day,
    Value<int>? id,
    Value<int>? month,
    Value<String>? name,
    Value<String?>? note,
    Value<int>? notificationHour,
    Value<int>? notificationMinute,
    Value<bool>? notificationScheduled,
    Value<String>? phone,
    Value<Uint8List?>? photo,
    Value<int?>? year,
  }) {
    return BirthdaysCompanion(
      createdAt: createdAt ?? this.createdAt,
      customMessage: customMessage ?? this.customMessage,
      day: day ?? this.day,
      id: id ?? this.id,
      month: month ?? this.month,
      name: name ?? this.name,
      note: note ?? this.note,
      notificationHour: notificationHour ?? this.notificationHour,
      notificationMinute: notificationMinute ?? this.notificationMinute,
      notificationScheduled:
          notificationScheduled ?? this.notificationScheduled,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      year: year ?? this.year,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (customMessage.present) {
      map['custom_message'] = Variable<String>(customMessage.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (notificationHour.present) {
      map['notification_hour'] = Variable<int>(notificationHour.value);
    }
    if (notificationMinute.present) {
      map['notification_minute'] = Variable<int>(notificationMinute.value);
    }
    if (notificationScheduled.present) {
      map['notification_scheduled'] = Variable<bool>(
        notificationScheduled.value,
      );
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (photo.present) {
      map['photo'] = Variable<Uint8List>(photo.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BirthdaysCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('customMessage: $customMessage, ')
          ..write('day: $day, ')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('name: $name, ')
          ..write('note: $note, ')
          ..write('notificationHour: $notificationHour, ')
          ..write('notificationMinute: $notificationMinute, ')
          ..write('notificationScheduled: $notificationScheduled, ')
          ..write('phone: $phone, ')
          ..write('photo: $photo, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BirthdaysTable birthdays = $BirthdaysTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [birthdays];
}

typedef $$BirthdaysTableCreateCompanionBuilder =
    BirthdaysCompanion Function({
      Value<DateTime> createdAt,
      Value<String?> customMessage,
      required int day,
      Value<int> id,
      required int month,
      required String name,
      Value<String?> note,
      Value<int> notificationHour,
      Value<int> notificationMinute,
      Value<bool> notificationScheduled,
      required String phone,
      Value<Uint8List?> photo,
      Value<int?> year,
    });
typedef $$BirthdaysTableUpdateCompanionBuilder =
    BirthdaysCompanion Function({
      Value<DateTime> createdAt,
      Value<String?> customMessage,
      Value<int> day,
      Value<int> id,
      Value<int> month,
      Value<String> name,
      Value<String?> note,
      Value<int> notificationHour,
      Value<int> notificationMinute,
      Value<bool> notificationScheduled,
      Value<String> phone,
      Value<Uint8List?> photo,
      Value<int?> year,
    });

class $$BirthdaysTableFilterComposer
    extends Composer<_$AppDatabase, $BirthdaysTable> {
  $$BirthdaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customMessage => $composableBuilder(
    column: $table.customMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationHour => $composableBuilder(
    column: $table.notificationHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationMinute => $composableBuilder(
    column: $table.notificationMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationScheduled => $composableBuilder(
    column: $table.notificationScheduled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BirthdaysTableOrderingComposer
    extends Composer<_$AppDatabase, $BirthdaysTable> {
  $$BirthdaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customMessage => $composableBuilder(
    column: $table.customMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationHour => $composableBuilder(
    column: $table.notificationHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationMinute => $composableBuilder(
    column: $table.notificationMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationScheduled => $composableBuilder(
    column: $table.notificationScheduled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BirthdaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $BirthdaysTable> {
  $$BirthdaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get customMessage => $composableBuilder(
    column: $table.customMessage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get notificationHour => $composableBuilder(
    column: $table.notificationHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationMinute => $composableBuilder(
    column: $table.notificationMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationScheduled => $composableBuilder(
    column: $table.notificationScheduled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<Uint8List> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);
}

class $$BirthdaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BirthdaysTable,
          Birthday,
          $$BirthdaysTableFilterComposer,
          $$BirthdaysTableOrderingComposer,
          $$BirthdaysTableAnnotationComposer,
          $$BirthdaysTableCreateCompanionBuilder,
          $$BirthdaysTableUpdateCompanionBuilder,
          (Birthday, BaseReferences<_$AppDatabase, $BirthdaysTable, Birthday>),
          Birthday,
          PrefetchHooks Function()
        > {
  $$BirthdaysTableTableManager(_$AppDatabase db, $BirthdaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BirthdaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BirthdaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BirthdaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> customMessage = const Value.absent(),
                Value<int> day = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> notificationHour = const Value.absent(),
                Value<int> notificationMinute = const Value.absent(),
                Value<bool> notificationScheduled = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<Uint8List?> photo = const Value.absent(),
                Value<int?> year = const Value.absent(),
              }) => BirthdaysCompanion(
                createdAt: createdAt,
                customMessage: customMessage,
                day: day,
                id: id,
                month: month,
                name: name,
                note: note,
                notificationHour: notificationHour,
                notificationMinute: notificationMinute,
                notificationScheduled: notificationScheduled,
                phone: phone,
                photo: photo,
                year: year,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> customMessage = const Value.absent(),
                required int day,
                Value<int> id = const Value.absent(),
                required int month,
                required String name,
                Value<String?> note = const Value.absent(),
                Value<int> notificationHour = const Value.absent(),
                Value<int> notificationMinute = const Value.absent(),
                Value<bool> notificationScheduled = const Value.absent(),
                required String phone,
                Value<Uint8List?> photo = const Value.absent(),
                Value<int?> year = const Value.absent(),
              }) => BirthdaysCompanion.insert(
                createdAt: createdAt,
                customMessage: customMessage,
                day: day,
                id: id,
                month: month,
                name: name,
                note: note,
                notificationHour: notificationHour,
                notificationMinute: notificationMinute,
                notificationScheduled: notificationScheduled,
                phone: phone,
                photo: photo,
                year: year,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BirthdaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BirthdaysTable,
      Birthday,
      $$BirthdaysTableFilterComposer,
      $$BirthdaysTableOrderingComposer,
      $$BirthdaysTableAnnotationComposer,
      $$BirthdaysTableCreateCompanionBuilder,
      $$BirthdaysTableUpdateCompanionBuilder,
      (Birthday, BaseReferences<_$AppDatabase, $BirthdaysTable, Birthday>),
      Birthday,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BirthdaysTableTableManager get birthdays =>
      $$BirthdaysTableTableManager(_db, _db.birthdays);
}
