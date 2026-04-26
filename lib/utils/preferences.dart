import 'package:flutter/material.dart' show TimeOfDay;
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static const globalMessage = 'global_message';
  static const notificationHour = 'notification_hour';
  static const notificationMinute = 'notification_minute';
  static const enableNotifications = 'enable_notifications';
  static const advanceNotice = 'advance_notice';
  static const darkMode = 'dark_mode';
  static const language = 'language';

  static bool? getAdvanceNotice() => _prefs.getBool(advanceNotice);
  static bool? getDarkMode() => _prefs.getBool(darkMode);
  static bool? getEnableNotifications() => _prefs.getBool(enableNotifications);
  static String? getGlobalMessage() => _prefs.getString(globalMessage);
  static String? getLanguage() => _prefs.getString(language);

  static TimeOfDay? getNotificationTime() {
    final hour = _prefs.getInt(notificationHour);
    final minute = _prefs.getInt(notificationMinute);

    if (hour == null || minute == null) return null;

    return TimeOfDay(hour: hour, minute: minute);
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveAdvanceNotice(bool value) =>
      _prefs.setBool(advanceNotice, value);

  static Future<void> saveDarkMode(bool value) =>
      _prefs.setBool(darkMode, value);

  static Future<void> saveEnableNotifications(bool value) =>
      _prefs.setBool(enableNotifications, value);

  static Future<void> saveGlobalMessage(String message) =>
      _prefs.setString(globalMessage, message);

  static Future<void> saveLanguage(String newLanguage) async {
    await _prefs.setString(language, newLanguage);
  }

  static Future<void> saveNotificationTime(TimeOfDay time) async {
    await _prefs.setInt(notificationHour, time.hour);
    await _prefs.setInt(notificationMinute, time.minute);
  }
}
