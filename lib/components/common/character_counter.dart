import 'package:flutter/material.dart'
    show
        Color,
        TextStyle,
        Text,
        StatelessWidget,
        Widget,
        WidgetsBinding,
        VoidCallback,
        BuildContext;

class CharacterCounter extends StatelessWidget {
  final int count;
  final int minimum;
  final String label;
  final VoidCallback? onMinimumReached;
  final VoidCallback? onTooShort;

  const CharacterCounter({
    super.key,
    required this.count,
    required this.minimum,
    required this.label,
    this.onMinimumReached,
    this.onTooShort,
  });

  @override
  Widget build(BuildContext context) {
    final meetsMinimum = count >= minimum;
    final color = meetsMinimum
        ? const Color(0xFF34C759)
        : const Color(0xFFFF3B30);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => meetsMinimum ? onMinimumReached?.call() : onTooShort?.call(),
    );

    return Text(label, style: TextStyle(fontSize: 11, color: color));
  }
}
