import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/handlers/handle_schedule_notification.dart'
    show handleScheduleNotification;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show BuildContext, TimeOfDay;

Future<bool> handleSaveBirthday({
  required BirthdayData birthdayData,
  required TimeOfDay notificationTime,
  required String globalMessage,
  required bool enableNotifications,
  required BuildContext context,
}) async {
  try {
    if (birthdayData.contactInfo == null) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.no_contact_selected_error,
      );
      return false;
    }

    if (birthdayData.contactInfo?.phone == null) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.no_contact_phone_error,
      );
      return false;
    }

    if (birthdayData.birthday == null) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.no_birthday_date_error,
      );
      return false;
    }

    final birthdayId = await DbManager.saveBirthday(
      name: birthdayData.contactInfo!.name,
      phone: birthdayData.contactInfo!.phone!,
      day: birthdayData.birthday!.day,
      month: birthdayData.birthday!.month,
      year: birthdayData.includeYear ? birthdayData.birthday!.year : null,
      customMessage: birthdayData.customMessage,
      note: birthdayData.note,
    );

    if (birthdayId <= 0) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.birthday_save_error,
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
          msg: AppLocalizations.of(context)!.birthday_saved_reminder_failed,
        );
        return true;
      }
    }

    showToast(
      type: .success,
      msg: enableNotifications
          ? AppLocalizations.of(context)!.birthday_saved_with_reminder
          : AppLocalizations.of(context)!.birthday_saved_no_reminder,
    );

    return true;
  } catch (e) {
    print(e);
    showToast(
      type: .error,
      msg: AppLocalizations.of(context)!.birthday_save_error,
    );
    return false;
  }
}
