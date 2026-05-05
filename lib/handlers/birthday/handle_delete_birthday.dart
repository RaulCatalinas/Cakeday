import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/notifications.dart' show deleteReminder;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show BuildContext;
import 'package:logkeeper/logkeeper.dart' show LogKeeper;

Future<bool> handleDeleteBirthday({
  required int id,
  required BuildContext context,
}) async {
  try {
    final deletedRows = await DbManager.deleteBirthday(id);

    final deletedBirthdaySuccessfully = deletedRows != 0;

    if (deletedBirthdaySuccessfully) {
      await deleteReminder(id: id);
    }

    showToast(
      type: deletedBirthdaySuccessfully ? .success : .error,
      msg: deletedBirthdaySuccessfully
          ? AppLocalizations.of(context)!.birthday_deleted_success
          : AppLocalizations.of(context)!.birthday_deleted_error,
    );

    return deletedBirthdaySuccessfully;
  } catch (e, stackTrace) {
    LogKeeper.error('Error deleting the birthday with id $id: $e');
    LogKeeper.error('StackTrace: $stackTrace');

    showToast(
      type: .error,
      msg: AppLocalizations.of(context)!.birthday_deleted_error,
    );

    return false;
  }
}
