import 'package:awesome_notifications/awesome_notifications.dart'
    show
        AwesomeNotifications,
        NotificationCalendar,
        NotificationChannel,
        NotificationContent,
        ReceivedAction;
import 'package:cakeday/utils/urls.dart' show openWhatsApp;
import 'package:flutter/material.dart' show TimeOfDay;

Future<void> configureNotification({
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
      repeats: true,
    ),
  );
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
  openWhatsApp(
    phone: '+34600826546',
    message: 'Hello from Flutter mobile app {name}',
    name: 'Raul Catalinas',
  );
}

void setupNotificationListeners() {
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: onNotificationReceived,
  );
}
