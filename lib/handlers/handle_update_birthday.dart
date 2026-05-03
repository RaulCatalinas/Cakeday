import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show BuildContext;

Future<bool> handleUpdateBirthday({
  required int id,
  required BuildContext context,
  required String name,
  required String phone,
  required int day,
  required int month,
  required int? year,
  required List<int>? photo,
  required String? customMessage,
  required String? note,
}) async {
  try {
    final success = await DbManager.updateBirthday(
      id: id,
      name: name,
      phone: phone,
      day: day,
      month: month,
      year: year,
      photo: photo,
      customMessage: customMessage,
      note: note,
    );

    if (!success) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.update_birthday_error,
      );
      return false;
    }

    showToast(
      type: .success,
      msg: AppLocalizations.of(context)!.update_birthday_success,
    );
    return true;
  } catch (e, stackTrace) {
    print('Error updating birthday: $e');
    print('StackTrace: $stackTrace');
    showToast(
      type: .error,
      msg: AppLocalizations.of(context)!.update_birthday_error,
    );

    return false;
  }
}
