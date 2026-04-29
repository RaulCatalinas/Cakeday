import 'package:cakeday/components/birthday/days_remaining.dart'
    show DaysRemaining;
import 'package:cakeday/components/birthday/schedule_birthday_notification.dart';
import 'package:cakeday/components/common/app_card.dart' show AppCard;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:flutter/material.dart'
    show
        BuildContext,
        CircleAvatar,
        Column,
        Expanded,
        MemoryImage,
        Padding,
        Row,
        StatelessWidget,
        Text,
        Theme,
        VoidCallback,
        Widget;

class ReminderCard extends StatelessWidget {
  final ContactInfo? contactInfo;
  final bool notificationScheduled;
  final VoidCallback? onRetryNotification;

  const ReminderCard({
    super.key,
    required this.contactInfo,
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
                    ? Text(name.isNotEmpty ? name[0].toUpperCase() : 'U')
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
                      phone?.trim() ?? 'Unknown',
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (birthday != null) DaysRemaining(birthday: birthday),
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
