import 'package:calendar_date_picker2/calendar_date_picker2.dart'
    show
        showCalendarDatePicker2Dialog,
        CalendarDatePicker2WithActionButtonsConfig;
import 'package:flutter/material.dart'
    show BuildContext, TextStyle, Color, Size;

Future<DateTime?> selectDate({required BuildContext context}) async {
  final results = await showCalendarDatePicker2Dialog(
    context: context,
    config: CalendarDatePicker2WithActionButtonsConfig(
      calendarType: .single,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year, 12, 31),
      selectedDayHighlightColor: const Color(0xFFFF6B6B),
      todayTextStyle: const TextStyle(color: Color(0xFFFF6B6B)),
      useAbbrLabelForMonthModePicker: true,
    ),
    dialogSize: const Size(325, 400),
    value: [DateTime.now()],
  );

  return results?.firstOrNull;
}
