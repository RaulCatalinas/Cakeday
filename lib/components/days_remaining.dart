import 'package:flutter/material.dart'
    show BuildContext, Color, StatelessWidget, Text, TextStyle, Widget, Theme;

class DaysRemaining extends StatelessWidget {
  final DateTime birthday;

  const DaysRemaining({super.key, required this.birthday});

  @override
  Widget build(BuildContext context) {
    final days = _daysRemaining();
    final age = _age();

    final ageText = age != null ? ' · Turns $age' : '';
    final daysText = switch (days) {
      0 => '🎉 Today!',
      1 => 'Tomorrow',
      _ => 'In $days days',
    };

    return Text(
      '$daysText$ageText',
      style: TextStyle(
        color: _color(days: days, context: context),
      ),
    );
  }

  int? _age() {
    if (birthday.year == 0) return null;

    final now = DateTime.now();
    var age = now.year - birthday.year;

    if (DateTime(now.year, birthday.month, birthday.day).isAfter(now)) {
      age++;
    }

    return age;
  }

  Color _color({required int days, required BuildContext context}) {
    return switch (days) {
      0 => const Color(0xFF34C759),
      <= 3 => const Color(0xFFFF6B6B),
      <= 7 => const Color(0xFFFF9F0A),
      _ => Theme.of(context).colorScheme.onSurfaceVariant,
    };
  }

  int _daysRemaining() {
    final now = DateTime.now();
    var nextBirthday = DateTime(now.year, birthday.month, birthday.day);

    if (nextBirthday.isBefore(now)) {
      nextBirthday = DateTime(now.year + 1, birthday.month, birthday.day);
    }

    return nextBirthday
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
