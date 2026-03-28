import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter_contacts/flutter_contacts.dart'
    show ContactProperty, FlutterContacts;
import 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionActions, PermissionStatus, openAppSettings;

Future<ContactInfo> pickContact() async {
  final contactId = await FlutterContacts.native.showPicker();

  if (contactId == null) return null;

  final contact = await FlutterContacts.get(
    contactId,
    properties: {
      ContactProperty.name,
      ContactProperty.phone,
      ContactProperty.photoThumbnail,
    },
  );

  if (contact == null) return null;

  final name = contact.displayName?.trim() ?? '';
  final phone = contact.phones.firstOrNull?.number.trim() ?? '';
  final photo = contact.photo?.fullSize;

  return (name, phone, photo, null);
}

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
