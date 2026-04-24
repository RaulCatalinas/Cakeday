// handlers/schedule_notification_handler.dart
import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/notifications.dart' show scheduleNotification;
import 'package:flutter/material.dart' show TimeOfDay;

Future<bool> handleScheduleNotification({
  required BirthdayData birthdayData,
  required TimeOfDay notificationTime,
  required int birthdayId,
  required String globalMessage,
}) async {
  try {
    final personalized = birthdayData.customMessage;
    final notificationBody = (personalized != null && personalized.isNotEmpty)
        ? personalized
        : globalMessage;

    await scheduleNotification(
      id: birthdayId,
      title: 'Birthday reminder',
      msg: notificationBody,
      date: birthdayData.birthday!,
      time: notificationTime,
    );

    await DbManager.setNotificationScheduled(birthdayId, true);

    return true;
  } catch (e) {
    print('Error setting up the notification: $e');

    return false;
  }
}
