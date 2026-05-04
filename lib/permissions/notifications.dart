import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart' show BuildContext;
import 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionActions, PermissionStatus, openAppSettings;

Future<PermissionStatus> requestNotificationsPermission({
  required BuildContext context,
}) async {
  return await Permission.notification
      .onDeniedCallback(() {
        showToast(
          type: .error,
          msg: AppLocalizations.of(context)!.notifications_permission_denied,
        );
      })
      .onPermanentlyDeniedCallback(() {
        showToast(
          type: .error,
          msg: AppLocalizations.of(
            context,
          )!.notifications_permission_permanently_denied,
        );
        openAppSettings();
      })
      .onRestrictedCallback(() {
        showToast(
          type: .error,
          msg: AppLocalizations.of(
            context,
          )!.notifications_permission_restricted,
        );
        openAppSettings();
      })
      .request();
}
