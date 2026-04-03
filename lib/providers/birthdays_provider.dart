import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:flutter_riverpod/flutter_riverpod.dart' show FutureProvider;

final birthdaysListProvider = FutureProvider<List<BirthdayData>>((ref) async {
  final rows = await DbManager.getAllBirthdays();

  return rows.map(BirthdayData.fromBirthday).toList();
});
