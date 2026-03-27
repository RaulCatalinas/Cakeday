import 'package:cakeday/types/contacts.dart' show ContactInfo;

class BirthdayData {
  final ContactInfo contactInfo;
  final DateTime? birthday;
  final bool includeYear;

  const BirthdayData({
    required this.contactInfo,
    required this.birthday,
    required this.includeYear,
  });
}
