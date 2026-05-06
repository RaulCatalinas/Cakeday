import 'package:awesome_notifications/awesome_notifications.dart'
    show
        AwesomeNotifications,
        NotificationCalendar,
        NotificationChannel,
        NotificationContent,
        ReceivedAction;
import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/utils/preferences.dart' show Preferences;
import 'package:cakeday/utils/urls.dart' show openWhatsApp;
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:logkeeper/logkeeper.dart' show LogKeeper;

Future<void> deleteReminder({required int id}) async {
  try {
    await AwesomeNotifications().cancel(id);
  } catch (e, stackTrace) {
    LogKeeper.error('Error deleting reminder with ID $id: $e');
    LogKeeper.error('StackTrace: $stackTrace');
  }
}

Future<void> initializeNotifications() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'birthdays',
      channelName: 'Birthday reminders',
      channelDescription: 'Notifications for birthday reminders',
    ),
  ]);
}

@pragma('vm:entry-point')
Future<void> onNotificationReceived(ReceivedAction action) async {
  final globalMessage = Preferences.getGlobalMessage();

  if (globalMessage == null) {
    LogKeeper.error(
      'No global message set. Please set a global message in preferences.',
    );

    return;
  }

  if (action.id == null) {
    LogKeeper.error(
      'Received notification action with null ID. Cannot proceed.',
    );

    return;
  }

  final birthday = await DbManager.getBirthdayById(action.id!);

  if (birthday == null) {
    LogKeeper.error('No birthday found for ID ${action.id}. Cannot proceed.');

    return;
  }

  final message = birthday.customMessage != null
      ? birthday.customMessage!
      : globalMessage.replaceAll('{name}', birthday.name);

  await openWhatsApp(
    phone: birthday.phone,
    message: message,
    name: birthday.name,
  );
}

Future<bool> scheduleNotification({
  required int id,
  required String title,
  required String msg,
  required DateTime date,
  required TimeOfDay time,
}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'birthdays',
      title: title,
      body: msg,
    ),
    schedule: NotificationCalendar(
      month: date.month,
      day: date.day,
      hour: time.hour,
      minute: time.minute,
      allowWhileIdle: true,
    ),
  );

  final scheduled = await AwesomeNotifications().listScheduledNotifications();

  return scheduled.any((n) => n.content?.id == id);
}

Future<void> setupNotificationListeners() async {
  try {
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onNotificationReceived,
    );
  } catch (e, stackTrace) {
    LogKeeper.error('Error setting up notification listeners: $e');
    LogKeeper.error('StackTrace: $stackTrace');
  }
}
