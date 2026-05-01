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
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:flutter/material.dart'
    show
        BuildContext,
        CircleAvatar,
        Column,
        Expanded,
        IconButton,
        MemoryImage,
        Padding,
        Row,
        StatelessWidget,
        Text,
        Theme,
        VoidCallback,
        Widget,
        ButtonStyle,
        Icon,
        Icons,
        Colors;

class ReminderCard extends StatelessWidget {
  static const _buttonStyles = ButtonStyle(enableFeedback: true);
  final ContactInfo? contactInfo;
  final bool notificationScheduled;
  final int? id;

  final VoidCallback? onRetryNotification;

  const ReminderCard({
    super.key,
    required this.contactInfo,
    this.id,
    this.notificationScheduled = true,
    this.onRetryNotification,
  });

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    mainAxisAlignment: .end,
                    crossAxisAlignment: .end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          // TODO: add logic to edit reminder

                          print('Editing reminder...');
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
