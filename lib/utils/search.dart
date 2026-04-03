import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/strings.dart' show StringNormalization;
import 'package:intl/intl.dart' show DateFormat;

extension BirthdayDataListSearch on List<BirthdayData> {
  List<BirthdayData> filtered({required String query, required String locale}) {
    if (query.isEmpty) return this;

    final normalizedQuery = query.normalized.toLowerCase();

    return where((b) {
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
}
