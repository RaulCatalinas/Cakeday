import 'dart:typed_data' show Uint8List;

import 'package:cakeday/components/app_card.dart' show AppCard;
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
        Widget;

class ReminderCard extends StatelessWidget {
  final String? name;
  final int? phoneNumber;
  final Uint8List? photo;

  const ReminderCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: 15.0,
      child: Row(
        mainAxisAlignment: .start,
        children: [
          const Padding(padding: .symmetric(horizontal: 8)),
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
              Text(phoneNumber?.toString() ?? 'Unknown'),
            ],
          ),
        ],
      ),
    );
  }
}
