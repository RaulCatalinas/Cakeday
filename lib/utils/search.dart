import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/strings.dart' show StringNormalization;
import 'package:intl/intl.dart' show DateFormat;

List<BirthdayData> filterBirthdays({
  required List<BirthdayData> birthdays,
  required String query,
  required String locale,
}) {
  if (query.isEmpty) return birthdays;

  final normalizedQuery = query.normalized.toLowerCase();

  return birthdays.where((b) {
    final nameMatch = b.contactInfo!.$1.normalized.toLowerCase().contains(
      normalizedQuery,
    );

    final formattedDate = b.birthday != null
        ? DateFormat.MMMMd(locale).format(b.birthday!).toLowerCase()
        : '';
    final dateMatch = formattedDate.contains(query.toLowerCase());

    return nameMatch || dateMatch;
  }).toList();
}
