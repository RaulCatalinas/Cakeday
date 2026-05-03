import 'package:cakeday/components/birthday/reminder_card.dart'
    show ReminderCard;
import 'package:cakeday/components/common/section_title.dart' show SectionTitle;
import 'package:cakeday/db/db_manager.dart';
import 'package:cakeday/handlers/notifications/handle_schedule_notification.dart'
    show handleScheduleNotification;
import 'package:cakeday/providers/birthdays_provider.dart';
import 'package:cakeday/providers/settings_provider.dart'
    show appSettingsProvider;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/strings.dart' show StringNormalization;
import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/material.dart'
    show BuildContext, ListView, Padding, TimeOfDay, Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

class RenderAllBirthdays extends ConsumerWidget {
  final List<BirthdayData> allBirthdays;

  const RenderAllBirthdays({super.key, required this.allBirthdays});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final flatItems = _prepareItemsToRender(items: allBirthdays);

    return ListView.builder(
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

        return ReminderCard(
          id: birthdayData.id,
          contactInfo: birthdayData.contactInfo,
          notificationScheduled: birthdayData.notificationScheduled,
          onRetryNotification: () async {
            await _onRetryNotification(
              contactName: birthdayData.contactInfo!.name,
              birthday: birthdayData.birthday!,
              birthdayId: birthdayData.id,
              notificationTime: settings.notificationTime,
              context: context,
            );

            ref.invalidate(birthdaysListProvider);
          },
        );
      },
    );
  }

  Future<void> _onRetryNotification({
    required String contactName,
    required DateTime birthday,
    required int? birthdayId,
    required TimeOfDay notificationTime,
    required BuildContext context,
  }) async {
    var id = birthdayId;

    if (id == null) {
      final birthdayId = await DbManager.getIdByName(contactName);

      if (birthdayId == null) return;

      id = birthdayId;
    }

    await handleScheduleNotification(
      notificationTime: notificationTime,
      contactName: contactName,
      birthday: birthday,
      birthdayId: id,
      context: context,
    );
  }

  List<Object> _prepareItemsToRender({required List<BirthdayData> items}) {
    items.sort((a, b) {
      final nameA = a.contactInfo!.name.normalizedInitial;
      final nameB = b.contactInfo!.name.normalizedInitial;
      return nameA.toLowerCase().compareTo(nameB.toLowerCase());
    });

    final itemsGrouped = groupBy(
      items,
      (birthdayData) => birthdayData.contactInfo!.name.normalizedInitial,
    );

    final List<Object> flatItems = [];

    for (final entry in itemsGrouped.entries) {
      flatItems.add(entry.key);
      flatItems.addAll(entry.value);
    }

    return flatItems;
  }
}
