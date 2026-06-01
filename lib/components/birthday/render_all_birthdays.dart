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
import 'package:cakeday/types/render_items.dart' show BirthdayItem, HeaderItem;
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
    final flatItems = _prepareItemsToRender(items: allBirthdays);

    return ListView.builder(
      itemCount: flatItems.length,
      itemBuilder: (context, index) {
        final item = flatItems[index];

        if (item is HeaderItem) {
          return Padding(
            padding: .only(top: 16, bottom: 8),
            child: SectionTitle(text: item.title),
          );
        }

        final birthdayItem = item as BirthdayItem;
        final birthdayData = birthdayItem.data;

        return ReminderCard(
          id: birthdayData.id,
          contactInfo: birthdayData.contactInfo,
          notificationScheduled: birthdayData.notificationScheduled,
          note: birthdayData.note,
          onRetryNotification: () async {
            final settings = ref.read(appSettingsProvider);

            await _onRetryNotification(
              contactName: birthdayData.contactInfo!.name,
              contactPhone: birthdayData.contactInfo!.phone ?? '',
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
    required String contactPhone,
    required DateTime birthday,
    required int? birthdayId,
    required TimeOfDay notificationTime,
    required BuildContext context,
  }) async {
    var id = birthdayId;

    if (id == null) {
      final birthdayId = await DbManager.getIdByInfo(
        name: contactName,
        phone: contactPhone,
        date: birthday,
      );

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
      final nameA = a.contactInfo!.name.normalized.toLowerCase();
      final nameB = b.contactInfo!.name.normalized.toLowerCase();
      return nameA.compareTo(nameB);
    });

    final itemsGrouped = groupBy(
      items,
      (birthdayData) => birthdayData.contactInfo!.name.normalizedInitial,
    );

    final List<Object> flatItems = [];

    for (final entry in itemsGrouped.entries) {
      flatItems.add(HeaderItem(entry.key));
      flatItems.addAll(entry.value.map(BirthdayItem.new));
    }

    return flatItems;
  }
}
