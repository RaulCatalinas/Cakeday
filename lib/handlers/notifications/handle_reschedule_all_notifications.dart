import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/handlers/notifications/handle_update_notification.dart'
    show handleUpdateNotification;
import 'package:flutter/material.dart' show BuildContext, TimeOfDay;
import 'package:logkeeper/logkeeper.dart' show LogKeeper;

Future<bool> handleRescheduleAllNotifications({
  required BuildContext context,
  required bool notifyDayBefore,
}) async {
  try {
    final birthdays = await DbManager.getAllBirthdays();

    if (birthdays.isEmpty) return false;

    for (final birthday in birthdays) {
      if (!birthday.notificationScheduled) continue;

      final notificationTime = TimeOfDay(
        hour: birthday.notificationHour,
        minute: birthday.notificationMinute,
      );

      await handleUpdateNotification(
        birthdayId: birthday.id,
        birthday: DateTime(birthday.year ?? 0, birthday.month, birthday.day),
        contactName: birthday.name,
        notificationTime: notificationTime,
        context: context,
        notifyDayBefore: notifyDayBefore,
      );
    }

    return true;
  } catch (e, stackTrace) {
    LogKeeper.error('Error rescheduling all reminders: $e');
    LogKeeper.error('StackTrace: $stackTrace');

    return false;
  }
}
