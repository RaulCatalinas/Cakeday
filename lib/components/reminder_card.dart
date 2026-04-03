import 'package:cakeday/components/app_card.dart' show AppCard;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:flutter/material.dart'
    show
        BuildContext,
        CircleAvatar,
        Column,
        MemoryImage,
        Padding,
        Row,
        StatelessWidget,
        Text,
        TextOverflow,
        Theme,
        Widget;

class ReminderCard extends StatelessWidget {
  final ContactInfo? contactInfo;

  const ReminderCard({super.key, required this.contactInfo});

  @override
  Widget build(BuildContext context) {
    final (name, phone, photo, _) =
        contactInfo ?? ('Unknown', 'Unknown', null, null);

    return AppCard(
      padding: 15.0,
      child: Row(
        mainAxisAlignment: .start,
        children: [
          const Padding(padding: .symmetric(horizontal: 8)),
          CircleAvatar(
            radius: 24,
            foregroundImage: photo != null ? MemoryImage(photo) : null,
            child: photo == null
                ? Text((name).isNotEmpty ? name[0].toUpperCase() : 'U')
                : null,
          ),
          const Padding(padding: .directional(start: 8, end: 8)),
          Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Padding(padding: .directional(top: 3, bottom: 3)),
              Text(
                phone?.trim() ?? 'Unknown',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
