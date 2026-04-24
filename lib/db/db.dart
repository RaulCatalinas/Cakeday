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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(birthdays, birthdays.notificationScheduled);
      }
    },
  );
}

class BirthdayDao extends DatabaseAccessor<AppDatabase> {
  BirthdayDao(super.attachedDatabase);

  Future<int> deleteBirthday(int id) {
    return (attachedDatabase.delete(
      attachedDatabase.birthdays,
    )..where((birthday) => birthday.id.equals(id))).go();
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
  TextColumn get phone => text()();
  BlobColumn get photo => blob().nullable()();
  IntColumn get year => integer().nullable()();
  BoolColumn get notificationScheduled =>
      boolean().withDefault(const Constant(false))();
}
