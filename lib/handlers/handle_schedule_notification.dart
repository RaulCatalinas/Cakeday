import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/notifications.dart' show scheduleNotification;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show BuildContext, TimeOfDay;

Future<bool> handleScheduleNotification({
  required String contactName,
  required TimeOfDay notificationTime,
  required DateTime birthday,
  required int birthdayId,
  required BuildContext context,
}) async {
  try {
    final reminderSet = await scheduleNotification(
      id: birthdayId,
      title: AppLocalizations.of(context)!.birthday_reminder_title,
      msg: AppLocalizations.of(context)!.birthday_reminder_body(contactName),
      date: birthday,
      time: notificationTime,
    );

    if (!reminderSet) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.reminder_configuration_failed,
      );

      return false;
    }

    final affectedRows = await DbManager.setNotificationScheduled(
      birthdayId,
      true,
    );

    if (affectedRows == 0) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.reminder_configuration_failed,
      );

      return false;
    }

    showToast(
      type: .success,
      msg: AppLocalizations.of(context)!.reminder_configured_successfully,
    );

    return true;
  } catch (e) {
    print('Error setting up the notification: $e');

    showToast(
      type: .error,
      msg: AppLocalizations.of(context)!.reminder_configuration_failed,
    );

    return false;
  }
}
