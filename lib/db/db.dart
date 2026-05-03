import 'dart:io' show File;

import 'package:drift/drift.dart'
    hide Column, DatabaseConnection, DatabaseConnectionUser;
import 'package:drift/native.dart' show NativeDatabase;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

part 'db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(join(dir.path, 'cakeday.db'));

    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [Birthdays])
class AppDatabase extends _$AppDatabase {
  late final BirthdayDao birthdayDao = BirthdayDao(this);

  AppDatabase() : super(_openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(birthdays, birthdays.notificationScheduled);
      }

      if (from < 3) {
        await migrator.addColumn(birthdays, birthdays.notificationHour);
        await migrator.addColumn(birthdays, birthdays.notificationMinute);
      }
    },
  );

  @override
  int get schemaVersion => 3;
}

class BirthdayDao extends DatabaseAccessor<AppDatabase> {
  BirthdayDao(super.attachedDatabase);

  Future<void> clearAll() async {
    await attachedDatabase.delete(attachedDatabase.birthdays).go();
  }

  Future<int> deleteBirthday(int id) {
    return (attachedDatabase.delete(
      attachedDatabase.birthdays,
    )..where((birthday) => birthday.id.equals(id))).go();
  }

  Future<bool> existsBirthday({
    required String name,
    required String phone,
  }) async {
    final query = attachedDatabase.select(attachedDatabase.birthdays)
      ..where((b) => b.name.equals(name) & b.phone.equals(phone))
      ..limit(1);

    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<bool> existsBirthdayById(int id) async {
    final count = attachedDatabase.birthdays.id.count();

    final query = attachedDatabase.selectOnly(attachedDatabase.birthdays)
      ..addColumns([count])
      ..where(attachedDatabase.birthdays.id.equals(id));

    final result = await query.getSingle();

    return result.read(count)! > 0;
  }

  Future<List<Birthday>> getAll() {
    final query = attachedDatabase.select(attachedDatabase.birthdays)
      ..orderBy([
        (birthday) => OrderingTerm.asc(birthday.month),
        (birthday) => OrderingTerm.asc(birthday.day),
        (birthday) => OrderingTerm.asc(birthday.name),
      ]);

    return query.get();
  }

  Future<Birthday?> getById(int id) {
    final query = attachedDatabase.select(attachedDatabase.birthdays)
      ..where((birthday) => birthday.id.equals(id));

    return query.getSingleOrNull();
  }

  Future<int?> getIdByName(String name) async {
    final query = attachedDatabase.select(attachedDatabase.birthdays)
      ..where((p) => p.name.equals(name));

    final result = await query.getSingleOrNull();
    return result?.id;
  }

  Future<int> insert(Insertable<Birthday> birthday) {
    return attachedDatabase.into(attachedDatabase.birthdays).insert(birthday);
  }

  /// Updates only columns present in [changes]. Do not set [BirthdaysCompanion.id]
  /// (the row is selected by [id]).
  Future<int> patchBirthday(int id, BirthdaysCompanion changes) {
    return (attachedDatabase.update(
      attachedDatabase.birthdays,
    )..where((b) => b.id.equals(id))).write(changes);
  }
}

class Birthdays extends Table {
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get customMessage => text().nullable()();
  IntColumn get day => integer()();
  IntColumn get id => integer().autoIncrement()();
  IntColumn get month => integer()();
  TextColumn get name => text()();
  TextColumn get note => text().nullable()();
  IntColumn get notificationHour => integer().withDefault(const Constant(9))();
  IntColumn get notificationMinute =>
      integer().withDefault(const Constant(0))();
  BoolColumn get notificationScheduled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get phone => text()();
  BlobColumn get photo => blob().nullable()();
  IntColumn get year => integer().nullable()();
}
