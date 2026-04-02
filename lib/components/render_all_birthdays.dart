import 'package:cakeday/components/reminder_card.dart' show ReminderCard;
import 'package:cakeday/components/section_title.dart' show SectionTitle;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/strings.dart' show StringNormalization;
import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/material.dart'
    show BuildContext, Expanded, ListView, Padding, StatelessWidget, Widget;

class RenderAllBirthdays extends StatelessWidget {
  final List<BirthdayData> allBirthdays;

  const RenderAllBirthdays({super.key, required this.allBirthdays});

  @override
  Widget build(BuildContext context) {
    final flatItems = _prepareItemsToRender(items: allBirthdays);

    return Expanded(
      child: ListView.builder(
        itemCount: flatItems.length,
        itemBuilder: (context, index) {
          final item = flatItems[index];

          if (item is String) {
            return Padding(
              padding: .only(top: 16, bottom: 8),
              child: SectionTitle(text: item),
            );
          }

          final birthdayData = item as BirthdayData;

          return ReminderCard(contactInfo: birthdayData.contactInfo);
        },
      ),
    );
  }

  List<Object> _prepareItemsToRender({required List<BirthdayData> items}) {
    items.sort((a, b) {
      final nameA = a.contactInfo!.$1.normalizedInitial;
      final nameB = b.contactInfo!.$1.normalizedInitial;

      return nameA.toLowerCase().compareTo(nameB.toLowerCase());
    });

    final itemsGrouped = groupBy(
      items,
      (birthdayData) => birthdayData.contactInfo!.$1.normalizedInitial,
    );

    final List<Object> flatItems = [];

    for (final entry in itemsGrouped.entries) {
      flatItems.add(entry.key);
      flatItems.addAll(entry.value);
    }

    return flatItems;
  }
}
