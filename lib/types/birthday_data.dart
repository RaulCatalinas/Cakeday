import 'package:cakeday/db/db.dart' show Birthday;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:flutter/material.dart' show TimeOfDay;

class BirthdayData {
  final int? id;
  final ContactInfo? contactInfo;
  final DateTime? birthday;
  final bool includeYear;
  final String? customMessage;
  final String? note;
  final bool notificationScheduled;
  final TimeOfDay? notificationHour;

  const BirthdayData({
    this.id,
    required this.contactInfo,
    required this.birthday,
    required this.includeYear,
    this.customMessage,
    this.note,
    this.notificationScheduled = false,
    this.notificationHour,
  });

  factory BirthdayData.fromBirthday(Birthday row) {
    return BirthdayData(
      id: row.id,
      contactInfo: ContactInfo(
        name: row.name,
        phone: row.phone,
        photo: row.photo,
        birthday: DateTime(row.year ?? 0, row.month, row.day),
      ),
      birthday: row.year != null
          ? DateTime(row.year!, row.month, row.day)
          : DateTime(0, row.month, row.day),
      includeYear: row.year != null && row.year != 0,
      customMessage: row.customMessage,
      note: row.note,
      notificationScheduled: row.notificationScheduled,
      notificationHour: TimeOfDay(
        hour: row.notificationHour,
        minute: row.notificationMinute,
      ),
    );
  }
}
