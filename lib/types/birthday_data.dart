import 'package:cakeday/types/contacts.dart' show ContactInfo;

class BirthdayData {
  final ContactInfo contactInfo;
  final DateTime? birthday;
  final bool includeYear;
  final String? customMessage;
  final String? note;

  const BirthdayData({
    required this.contactInfo,
    required this.birthday,
    required this.includeYear,
    this.customMessage,
    this.note,
  });
}
