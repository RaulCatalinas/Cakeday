import 'package:cakeday/components/app_card.dart' show AppCard;
import 'package:cakeday/components/days_remaining.dart' show DaysRemaining;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:flutter/material.dart'
    show
        BuildContext,
        ButtonStyle,
        CircleAvatar,
        Color,
        Column,
        Expanded,
        Icon,
        Icons,
        MemoryImage,
        Padding,
        Row,
        StatelessWidget,
        Text,
        TextButton,
        TextStyle,
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

  static const _buttonStyles = ButtonStyle(enableFeedback: true);

  @override
  Widget build(BuildContext context) {
    final (name, phone, photo, birthday) =
        contactInfo ?? ('Unknown', 'Unknown', null, null);

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
            Row(
              children: [
                const Icon(
                  Icons.warning_amber,
                  color: Color(0xFFFF9F0A),
                  size: 16,
                ),
                const Padding(padding: .symmetric(horizontal: 4)),
                const Expanded(
                  child: Text(
                    'Notification could not be scheduled',
                    style: TextStyle(fontSize: 12, color: Color(0xFFFF9F0A)),
                  ),
                ),
                TextButton(
                  onPressed: onRetryNotification,
                  style: _buttonStyles,
                  child: const Text('Retry'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
