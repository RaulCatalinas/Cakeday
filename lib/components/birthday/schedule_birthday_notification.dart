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
  final VoidCallback? onRetryNotification;

  const ScheduleBirthdayNotification({super.key, this.onRetryNotification});

  static const _buttonStyles = ButtonStyle(enableFeedback: true);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.warning_amber, color: Color(0xFFFF9F0A), size: 16),
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
    );
  }
}
