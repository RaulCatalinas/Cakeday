import 'package:cakeday/components/app_card.dart' show AppCard;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:flutter/material.dart'
    show
        BuildContext,
        CircleAvatar,
        Column,
        Localizations,
        MemoryImage,
        Padding,
        Row,
        StatelessWidget,
        Text,
        Widget;
import 'package:intl/intl.dart';

class ReminderCard extends StatelessWidget {
  final ContactInfo? contactInfo;

  const ReminderCard({super.key, required this.contactInfo});

  @override
  Widget build(BuildContext context) {
    final (name, phone, photo, birthday) =
        contactInfo ?? ('Unknown', 'Unknown', null, null);

    final locale = Localizations.localeOf(context).toString();
    final formatted = birthday != null
        ? DateFormat.MMMMd(locale).format(birthday)
        : 'Unknown';

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
              Text(name),
              const Padding(padding: .directional(top: 3, bottom: 3)),
              Text(formatted),
            ],
          ),
        ],
      ),
    );
  }
}
