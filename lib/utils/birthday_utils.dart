import 'package:cakeday/db/db.dart' show Birthday;

int daysUntilBirthday({required int month, required int day}) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  var next = DateTime(now.year, month, day);

  if (next.isBefore(today)) {
    next = DateTime(now.year + 1, month, day);
  }

  return next.difference(today).inDays;
}

bool isTodayBirthday(Birthday birthday) {
  final now = DateTime.now();

  return birthday.month == now.month && birthday.day == now.day;
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
