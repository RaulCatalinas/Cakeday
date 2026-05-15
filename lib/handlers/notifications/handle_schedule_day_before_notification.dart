import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/notifications.dart'
    show scheduleDayBeforeNotification;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show BuildContext, TimeOfDay;
import 'package:logkeeper/logkeeper.dart' show LogKeeper;

Future<bool> handleScheduleDayBeforeNotification({
  required String contactName,
  required TimeOfDay notificationTime,
  required DateTime birthday,
  required int birthdayId,
  required BuildContext context,
}) async {
  try {
    final reminderSet = await scheduleDayBeforeNotification(
      id: birthdayId,
      title: AppLocalizations.of(context)!.birthday_reminder_day_before_title,
      msg: AppLocalizations.of(
        context,
      )!.birthday_reminder_day_before_body(contactName),
      date: birthday,
      time: notificationTime,
    );

    if (!reminderSet) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(
          context,
        )!.day_before_reminder_configuration_failed,
      );

      return false;
    }

    showToast(
      type: .success,
      msg: AppLocalizations.of(
        context,
      )!.day_before_reminder_configured_successfully,
    );

    return true;
  } catch (e, stackTrace) {
    LogKeeper.error('Error setting up the notification: $e');
    LogKeeper.error('StackTrace: $stackTrace');

    showToast(
      type: .error,
      msg: AppLocalizations.of(
        context,
      )!.day_before_reminder_configuration_failed,
    );

    return false;
  }
}
