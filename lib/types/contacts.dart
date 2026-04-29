import 'dart:typed_data' show Uint8List;

class ContactInfo {
  final String name;
  final String? phone;
  final Uint8List? photo;
  final DateTime? birthday;

  const ContactInfo({
    required this.name,
    this.phone,
    this.photo,
    this.birthday,
  });

  (String, String?, Uint8List?, DateTime?) get asRecord =>
      (name, phone, photo, birthday);
}
