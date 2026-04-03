import 'dart:typed_data' show Uint8List;

import 'package:cakeday/db/db.dart'
    show AppDatabase, BirthdaysCompanion, Birthday;
import 'package:drift/drift.dart' show Value;

class DbManager {
  static final DbManager _instance = DbManager._internal();
  late final AppDatabase _db;

  factory DbManager() => _instance;

  DbManager._internal();

  Future<int> deleteBirthday(int id) => _db.birthdayDao.deleteBirthday(id);
  Future<List<Birthday>> getAllBirthdays() => _db.birthdayDao.getAll();
  Future<Birthday?> getBirthdayById(int id) => _db.birthdayDao.getById(id);

  static Future<void> init() async {
    _instance._db = AppDatabase();
  }

  /// Partial update: only columns present in [changes] are written.
  static Future<int> patchBirthday(int id, BirthdaysCompanion changes) =>
      _instance._db.birthdayDao.patchBirthday(id, changes);

  static Future<int> saveBirthday({
    required String name,
    required String phone,
    required int day,
    required int month,
    int? year,
    List<int>? photo,
    String? customMessage,
    String? note,
  }) => _instance._db.birthdayDao.insert(
    BirthdaysCompanion(
      name: Value(name),
      phone: Value(phone),
      day: Value(day),
      month: Value(month),
      year: Value(year),
      photo: Value(photo != null ? Uint8List.fromList(photo) : null),
      customMessage: Value(customMessage),
      note: Value(note),
    ),
  );

  /// Full row replace (all main fields) for [id]. Same persistence as patch with every column set.
  static Future<bool> updateBirthday({
    required int id,
    required String name,
    required String phone,
    required int day,
    required int month,
    int? year,
    List<int>? photo,
    String? customMessage,
    String? note,
  }) async {
    final rows = await patchBirthday(
      id,
      BirthdaysCompanion(
        name: Value(name),
        phone: Value(phone),
        day: Value(day),
        month: Value(month),
        year: Value(year),
        photo: Value(photo != null ? Uint8List.fromList(photo) : null),
        customMessage: Value(customMessage),
        note: Value(note),
      ),
    );

    return rows > 0;
  }
}
