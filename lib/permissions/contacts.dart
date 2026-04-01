import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionActions, PermissionStatus, openAppSettings;

Future<PermissionStatus> requestContactListPermission() async {
  return await Permission.contacts
      .onDeniedCallback(() {
        showToast(
          type: .error,
          msg:
              'To add birthdays quickly, allow Cakeday to access your contacts in Settings.',
        );
      })
      .onPermanentlyDeniedCallback(() {
        showToast(
          type: .error,
          msg:
              'Contacts access is blocked. Enable it manually in your phone\'s Settings.',
        );
        openAppSettings();
      })
      .onLimitedCallback(() {
        showToast(
          type: .error,
          msg: 'You\'ve granted limited access. Some contacts may not appear.',
        );
      })
      .onRestrictedCallback(() {
        showToast(
          type: .error,
          msg:
              'Contacts access is restricted by your device. Check your parental or device settings.',
        );
        openAppSettings();
      })
      .request();
}
