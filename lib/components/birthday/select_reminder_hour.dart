import 'package:cakeday/components/common/subtitle.dart' show Subtitle;
import 'package:cakeday/components/layout/clickable_card.dart';
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/time.dart' show selectHour;
import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        Column,
        Expanded,
        Icon,
        Icons,
        MaterialLocalizations,
        Row,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        Theme,
        TimeOfDay,
        Widget;

class SelectReminderHour extends StatefulWidget {
  final Function(TimeOfDay) onSelectedHour;
  final Function(TimeOfDay)? onInit;
  final BorderRadius? borderRadius;
  final TimeOfDay? initialHour;

  const SelectReminderHour({
    super.key,
    required this.onSelectedHour,
    this.onInit,
    this.borderRadius,
    this.initialHour,
  });

  @override
  State<SelectReminderHour> createState() => _SelectReminderHourState();
}

class _SelectReminderHourState extends State<SelectReminderHour> {
  late TimeOfDay selectedHour;

  @override
  Widget build(BuildContext context) {
    final formattedTime = MaterialLocalizations.of(
      context,
    ).formatTimeOfDay(selectedHour);

    return ClickableCard(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      borderRadius: widget.borderRadius,
      onTap: () async {
        final hour = await selectHour(context: context);

        if (hour == null) return;

        setState(() => selectedHour = hour);
        widget.onSelectedHour(hour);
      },
      child: Row(
        mainAxisAlignment: .center,
        children: [
          const Icon(Icons.alarm),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(AppLocalizations.of(context)!.notification_time),
                Subtitle(
                  text: AppLocalizations.of(
                    context,
                  )!.notification_time_subtitle,
                ),
              ],
            ),
          ),
          Text(formattedTime),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 20),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    selectedHour = widget.initialHour ?? const TimeOfDay(hour: 9, minute: 0);

    widget.onInit?.call(selectedHour);
  }
}
