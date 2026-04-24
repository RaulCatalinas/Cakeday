import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/handlers/handle_schedule_notification.dart'
    show handleScheduleNotification;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show TimeOfDay;

Future<bool> handleSaveBirthday({
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

      return false;
    }

    if (birthdayData.contactInfo?.$2 == null) {
      showToast(
        type: .error,
        msg:
            'We were unable to retrieve the number for the selected contact. Please try again later.',
      );

      return false;
    }

    if (birthdayData.birthday == null) {
      showToast(type: .error, msg: 'Please select the birthday');

      return false;
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

      return false;
    }

    if (enableNotifications) {
      final scheduledNotification = await handleScheduleNotification(
        birthdayId: birthdayId,
        birthdayData: birthdayData,
        notificationTime: notificationTime,
        globalMessage: globalMessage,
      );

      if (!scheduledNotification) {
        showToast(
          type: .warning,
          msg:
              'Birthday saved, but the reminder could not be scheduled. Check notification permissions.',
        );
      }
    }

    showToast(
      type: .success,
      msg: enableNotifications
          ? 'Birthday saved and reminder scheduled'
          : 'Birthday saved successfully',
    );

    return true;
  } catch (e) {
    print(e);
    showToast(
      type: .error,
      msg: 'We were unable to save the birthday; please try again later',
    );

    return false;
  }
}
