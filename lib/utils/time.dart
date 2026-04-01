import 'package:flutter/material.dart'
    show TimeOfDay, BuildContext, showTimePicker;

Future<TimeOfDay?> selectHour({required BuildContext context}) async {
  return await showTimePicker(context: context, initialTime: TimeOfDay.now());
}
