import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/notifications.dart'
    show deleteReminder, scheduleNotification;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show BuildContext, TimeOfDay;

Future<bool> handleUpdateNotification({
  required int birthdayId,
  required DateTime birthday,
  required String contactName,
  required TimeOfDay notificationTime,
  required BuildContext context,
}) async {
  try {
    await deleteReminder(id: birthdayId);

    final scheduled = await scheduleNotification(
      id: birthdayId,
      title: AppLocalizations.of(context)!.birthday_reminder_title,
      msg: AppLocalizations.of(context)!.birthday_reminder_body(contactName),
      date: birthday,
      time: notificationTime,
    );

    if (!scheduled) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.reminder_update_failed,
      );
      return false;
    }

    showToast(
      type: .success,
      msg: AppLocalizations.of(context)!.reminder_updated_successfully,
    );

    return true;
  } catch (e, stackTrace) {
    print('Error updating the notification: $e');
    print('StackTrace: $stackTrace');

    showToast(
      type: .error,
      msg: AppLocalizations.of(context)!.reminder_update_failed,
    );

    return false;
  }
}
