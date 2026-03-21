import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        Row,
        StatelessWidget,
        Widget,
        Padding,
        CircleAvatar,
        MemoryImage,
        Text,
        Column;
import 'package:flutter/material.dart' show Localizations;
import 'package:intl/intl.dart' show DateFormat;

class ReminderCard extends StatelessWidget {
  final String? name;
  final DateTime? birthdayDate;
  final Uint8List? photo;

  const ReminderCard({
    super.key,
    required this.name,
    required this.birthdayDate,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final formatted = birthdayDate != null
        ? DateFormat.yMMMMd(locale).format(birthdayDate!)
        : 'Unknown';

    return Card(
      child: Row(
        mainAxisAlignment: .start,
        children: [
          const Padding(padding: .symmetric(vertical: 16, horizontal: 8)),
          CircleAvatar(
            radius: 24,
            foregroundImage: photo != null ? MemoryImage(photo!) : null,
            child: photo == null
                ? Text(name != null ? name![0].toUpperCase() : 'U')
                : null,
          ),
          const Padding(padding: .directional(start: 8, end: 8)),
          Column(
            mainAxisAlignment: .center,
            children: [
              Text(name ?? 'Unknown'),
              const Padding(padding: .directional(top: 3, bottom: 3)),
              Text(formatted),
            ],
          ),
        ],
      ),
    );
  }
}
