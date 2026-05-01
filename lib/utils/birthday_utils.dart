import 'package:cakeday/db/db.dart' show Birthday;
import 'package:cakeday/l10n/app_localizations.dart';
import 'package:flutter/material.dart' show BuildContext;

int daysUntilBirthday({required int month, required int day}) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  var next = DateTime(now.year, month, day);

  if (next.isBefore(today)) {
    next = DateTime(now.year + 1, month, day);
  }

  return next.difference(today).inDays;
}

List<Birthday> filterTodayBirthdays(List<Birthday> birthdays) {
  return birthdays.where(isTodayBirthday).toList();
}

List<Birthday> filterUpcomingBirthdays(
  List<Birthday> birthdays, {
  int withinDays = 30,
}) {
  return birthdays.where((birthday) {
    final days = daysUntilBirthday(month: birthday.month, day: birthday.day);
    return days > 0 && days <= withinDays;
  }).toList()..sort(
    (a, b) => daysUntilBirthday(
      month: a.month,
      day: a.day,
    ).compareTo(daysUntilBirthday(month: b.month, day: b.day)),
  );
}

String formatTimeUntilBirthday({
  required int days,
  required BuildContext context,
}) {
  return switch (days) {
    < 14 => AppLocalizations.of(context)!.days_remaining(days),
    < 90 => AppLocalizations.of(context)!.weeks_remaining((days / 7).floor()),
    < 365 => AppLocalizations.of(
      context,
    )!.months_remaining((days / 30).floor()),

    _ => () {
      final years = (days / 365).floor();
      final remainingMonths = ((days % 365) / 30).floor();

      return remainingMonths == 0
          ? AppLocalizations.of(context)!.years_remaining(years)
          : AppLocalizations.of(
              context,
            )!.years_and_months_remaining(years, remainingMonths);
    }(),
  };
}

bool isTodayBirthday(Birthday birthday) {
  final now = DateTime.now();

  return birthday.month == now.month && birthday.day == now.day;
}
