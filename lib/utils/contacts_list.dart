import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:flutter_contacts/flutter_contacts.dart'
    show ContactProperty, FlutterContacts;

Future<ContactInfo?> pickContact() async {
  final contact = await FlutterContacts.native.showPicker(
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

  return ContactInfo(name: name, phone: phone, photo: photo);
}
