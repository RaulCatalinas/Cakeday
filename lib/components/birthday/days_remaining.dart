import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/birthday_utils.dart'
    show daysUntilBirthday, formatTimeUntilBirthday;
import 'package:flutter/material.dart'
    show BuildContext, Color, StatelessWidget, Text, TextStyle, Widget, Theme;

class DaysRemaining extends StatelessWidget {
  final DateTime birthday;

  const DaysRemaining({super.key, required this.birthday});

  @override
  Widget build(BuildContext context) {
    final days = daysUntilBirthday(month: birthday.month, day: birthday.day);
    final age = _age();

    final ageText = age != null
        ? ' · ${AppLocalizations.of(context)!.turns_age(age)}'
        : '';
    final text = switch (days) {
      0 => '🎉 ${AppLocalizations.of(context)!.today_text}!',
      1 => AppLocalizations.of(context)!.tomorrow_text,
      _ => formatTimeUntilBirthday(days: days, context: context),
    };

    return Text(
      '$text$ageText',
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
}
