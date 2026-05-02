import 'package:cakeday/components/birthday/days_remaining.dart'
    show DaysRemaining;
import 'package:cakeday/components/birthday/schedule_birthday_notification.dart'
    show ScheduleBirthdayNotification;
import 'package:cakeday/components/common/app_card.dart' show AppCard;
import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/dialogs/confirm_delete_birthday.dart'
    show showConfirmDeleteBirthdayDialog;
import 'package:cakeday/handlers/handle_delete_birthday.dart'
    show handleDeleteBirthday;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/providers/birthdays_provider.dart'
    show birthdaysListProvider;
import 'package:cakeday/screens/add_birthday.dart' show AddBirthdayScreen;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:flutter/material.dart'
    show
        BuildContext,
        ButtonStyle,
        CircleAvatar,
        Colors,
        Column,
        Expanded,
        Icon,
        IconButton,
        Icons,
        MaterialPageRoute,
        MemoryImage,
        Navigator,
        Padding,
        Row,
        Text,
        Theme,
        VoidCallback,
        Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

class ReminderCard extends ConsumerWidget {
  static const _buttonStyles = ButtonStyle(enableFeedback: true);
  final ContactInfo? contactInfo;
  final bool notificationScheduled;
  final bool showActionButtons;
  final int? id;

  final VoidCallback? onRetryNotification;

  const ReminderCard({
    super.key,
    required this.contactInfo,
    this.id,
    this.notificationScheduled = false,
    this.showActionButtons = true,
    this.onRetryNotification,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (name, phone, photo, birthday) =
        contactInfo?.asRecord ??
        (
          AppLocalizations.of(context)!.unknown_text,
          AppLocalizations.of(context)!.unknown_text,
          null,
          null,
        );

    return AppCard(
      padding: 15.0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .start,
            children: [
              const Padding(padding: .symmetric(horizontal: 8)),
              CircleAvatar(
                radius: 24,
                foregroundImage: photo != null ? MemoryImage(photo) : null,
                child: photo == null
                    ? Text(
                        name.isNotEmpty
                            ? name[0].toUpperCase()
                            : AppLocalizations.of(
                                context,
                              )!.unknown_text[0].toUpperCase(),
                      )
                    : null,
              ),
              const Padding(padding: .directional(start: 8, end: 8)),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Padding(padding: .directional(top: 3, bottom: 3)),
                    Text(
                      phone?.trim() ??
                          AppLocalizations.of(context)!.unknown_text,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: .end,
                crossAxisAlignment: .end,
                children: [
                  if (showActionButtons)
                    Row(
                      mainAxisAlignment: .end,
                      crossAxisAlignment: .end,
                      children: [
                        IconButton(
                          onPressed: () async {
                            var birthdayId = id;

                            if (birthdayId == null) {
                              final id = await DbManager.getIdByName(name);

                              birthdayId = id;
                            }

                            final birthday = await DbManager.getBirthdayById(
                              birthdayId!,
                            );

                            if (birthday == null) return;

                            final birthdayData = BirthdayData.fromBirthday(
                              birthday,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddBirthdayScreen(
                                  birthdayToEdit: birthdayData,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          style: _buttonStyles,
                        ),
                        IconButton(
                          onPressed: () async {
                            var birthdayId = id;

                            final deleteReminder =
                                await showConfirmDeleteBirthdayDialog(
                                  context: context,
                                );

                            if (deleteReminder) {
                              if (birthdayId == null) {
                                final id = await DbManager.getIdByName(name);

                                birthdayId = id;
                              }

                              await handleDeleteBirthday(
                                id: birthdayId!,
                                context: context,
                              );

                              ref.invalidate(birthdaysListProvider);
                            }
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                          style: _buttonStyles,
                        ),
                      ],
                    ),
                  if (birthday != null) DaysRemaining(birthday: birthday),
                ],
              ),
            ],
          ),

          if (!notificationScheduled)
            ScheduleBirthdayNotification(
              onRetryNotification: onRetryNotification,
            ),
        ],
      ),
    );
  }
}
