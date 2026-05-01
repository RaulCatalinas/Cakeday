import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show BuildContext, TimeOfDay;

Future<(bool, int?)> handleSaveBirthday({
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
      return (false, null);
    }

    if (birthdayData.contactInfo?.phone == null) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.no_contact_phone_error,
      );
      return (false, null);
    }

    if (birthdayData.birthday == null) {
      showToast(
        type: .error,
        msg: AppLocalizations.of(context)!.no_birthday_date_error,
      );
      return (false, null);
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
      return (false, null);
    }

    showToast(
      type: .success,
      msg: AppLocalizations.of(context)!.birthday_saved,
    );

    return (true, birthdayId);
  } catch (e) {
    print(e);
    showToast(
      type: .error,
      msg: AppLocalizations.of(context)!.birthday_save_error,
    );
    return (false, null);
  }
}
