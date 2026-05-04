import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show BuildContext;
import 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionActions, PermissionStatus, openAppSettings;

Future<PermissionStatus> requestContactListPermission({
  required BuildContext context,
}) async {
  return await Permission.contacts
      .onDeniedCallback(() {
        showToast(
          type: .error,
          msg: AppLocalizations.of(context)!.contacts_permission_denied,
        );
      })
      .onPermanentlyDeniedCallback(() {
        showToast(
          type: .error,
          msg: AppLocalizations.of(
            context,
          )!.contacts_permission_permanently_denied,
        );
        openAppSettings();
      })
      .onLimitedCallback(() {
        showToast(
          type: .error,
          msg: AppLocalizations.of(context)!.contacts_permission_limited,
        );
      })
      .onRestrictedCallback(() {
        showToast(
          type: .error,
          msg: AppLocalizations.of(context)!.contacts_permission_restricted,
        );
        openAppSettings();
      })
      .request();
}
