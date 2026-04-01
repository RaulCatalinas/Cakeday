import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionActions, PermissionStatus, openAppSettings;

Future<PermissionStatus> requestNotificationsPermission() async {
  return await Permission.notification
      .onDeniedCallback(() {
        showToast(
          type: .error,
          msg: 'Allow notifications so Cakeday can remind you on birthdays.',
        );
      })
      .onPermanentlyDeniedCallback(() {
        showToast(
          type: .error,
          msg:
              'Notifications are blocked. Enable them manually in your phone\'s Settings.',
        );
        openAppSettings();
      })
      .onRestrictedCallback(() {
        showToast(
          type: .error,
          msg:
              'Notifications are restricted by your device. Check your parental or device settings.',
        );
        openAppSettings();
      })
      .request();
}
