import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:flutter/material.dart'
    show
        BuildContext,
        ButtonStyle,
        Color,
        Expanded,
        Icon,
        Icons,
        Padding,
        Row,
        StatelessWidget,
        Text,
        TextButton,
        TextStyle,
        VoidCallback,
        Widget;

class ScheduleBirthdayNotification extends StatelessWidget {
  static const _buttonStyles = ButtonStyle(enableFeedback: true);

  final VoidCallback? onRetryNotification;

  const ScheduleBirthdayNotification({super.key, this.onRetryNotification});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.warning_amber, color: Color(0xFFFF9F0A), size: 16),
        const Padding(padding: .symmetric(horizontal: 4)),
        Expanded(
          child: Text(
            AppLocalizations.of(context)!.notification_could_not_be_scheduled,
            style: const TextStyle(fontSize: 12, color: Color(0xFFFF9F0A)),
          ),
        ),
        TextButton(
          onPressed: onRetryNotification,
          style: _buttonStyles,
          child: Text(AppLocalizations.of(context)!.retry_text),
        ),
      ],
    );
  }
}
