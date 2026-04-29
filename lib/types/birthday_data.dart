import 'package:cakeday/db/db.dart' show Birthday;
import 'package:cakeday/types/contacts.dart' show ContactInfo;

class BirthdayData {
  final int? id;
  final ContactInfo? contactInfo;
  final DateTime? birthday;
  final bool includeYear;
  final String? customMessage;
  final String? note;
  final bool notificationScheduled;

  const BirthdayData({
    this.id,
    required this.contactInfo,
    required this.birthday,
    required this.includeYear,
    this.customMessage,
    this.note,
    this.notificationScheduled = false,
  });

  factory BirthdayData.fromBirthday(Birthday row) {
    return BirthdayData(
      contactInfo: ContactInfo(
        name: row.name,
        phone: row.phone,
        photo: row.photo,
      ),
      birthday: row.year != null
          ? DateTime(row.year!, row.month, row.day)
          : DateTime(0, row.month, row.day),
      includeYear: row.year != null,
      customMessage: row.customMessage,
      note: row.note,
    );
  }
}
