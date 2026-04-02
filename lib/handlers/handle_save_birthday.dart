import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
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

    // TODO: Save to SQLite and retrieve the ID
    // TODO: set up notifications if `enableNotifications` is true

    showToast(type: .success, msg: 'Birthday saved successfully');
  } catch (e) {
    print(e);
    showToast(
      type: .error,
      msg: 'We were unable to save the birthday; please try again later',
    );
  }
}
