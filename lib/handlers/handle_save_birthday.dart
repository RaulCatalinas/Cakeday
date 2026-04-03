import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/notifications.dart';
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show TimeOfDay;

Future<void> handleSaveBirthday({
  required BirthdayData birthdayData,
  required TimeOfDay notificationTime,
  required String globalMessage,
  required bool enableNotifications,
}) async {
  try {
    if (birthdayData.contactInfo == null) {
      showToast(
        type: .error,
        msg: 'Please select a contact from your contact list',
      );

      return;
    }

    if (birthdayData.contactInfo?.$2 == null) {
      showToast(
        type: .error,
        msg:
            'We were unable to retrieve the number for the selected contact. Please try again later.',
      );

      return;
    }

    if (birthdayData.birthday == null) {
      showToast(type: .error, msg: 'Please select the birthday');

      return;
    }

    final birthdayId = await DbManager.saveBirthday(
      name: birthdayData.contactInfo!.$1,
      phone: birthdayData.contactInfo!.$2!,
      day: birthdayData.birthday!.day,
      month: birthdayData.birthday!.month,
      year: birthdayData.includeYear ? birthdayData.birthday!.year : null,
      customMessage: birthdayData.customMessage,
      note: birthdayData.note,
    );

    if (birthdayId <= 0) {
      showToast(
        type: .error,
        msg: 'We were unable to save the birthday; please try again later',
      );

      return;
    }

    final personalized = birthdayData.customMessage?.trim();
    final notificationBody = (personalized != null && personalized.isNotEmpty)
        ? personalized
        : globalMessage;

    if (enableNotifications) {
      try {
        await scheduleNotification(
          id: birthdayId,
          title: 'Birthday reminder',
          msg: notificationBody,
          date: birthdayData.birthday!,
          time: notificationTime,
        );
      } catch (e) {
        print(e);
        showToast(
          type: .warning,
          msg:
              'Birthday saved, but the reminder could not be scheduled. Check notification permissions.',
        );

        return;
      }
    }

    showToast(
      type: .success,
      msg: enableNotifications
          ? 'Birthday saved and reminder scheduled'
          : 'Birthday saved successfully',
    );
  } catch (e) {
    print(e);
    showToast(
      type: .error,
      msg: 'We were unable to save the birthday; please try again later',
    );
  }
}
