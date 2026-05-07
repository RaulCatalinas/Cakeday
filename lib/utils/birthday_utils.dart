import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
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

List<BirthdayData> filterTodayBirthdays(List<BirthdayData> birthdays) {
  return birthdays.where((b) => isTodayBirthday(b.birthday!)).toList();
}

List<BirthdayData> filterUpcomingBirthdays(
  List<BirthdayData> birthdays, {
  int withinDays = 30,
}) {
  return birthdays.where((b) {
    final days = daysUntilBirthday(
      month: b.birthday!.month,
      day: b.birthday!.day,
    );

    return days > 0 && days <= withinDays;
  }).toList()..sort(
    (a, b) => daysUntilBirthday(month: a.birthday!.month, day: a.birthday!.day)
        .compareTo(
          daysUntilBirthday(month: b.birthday!.month, day: b.birthday!.day),
        ),
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

bool isTodayBirthday(DateTime birthday) {
  final now = DateTime.now();

  return birthday.month == now.month && birthday.day == now.day;
}
