// settings_provider.dart
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appSettingsProvider = NotifierProvider<AppSettingsNotifier, AppSettings>(
  AppSettingsNotifier.new,
);

class AppSettings {
  final String globalMessage;
  final TimeOfDay notificationTime;
  final bool enableNotifications;
  final bool advanceNotice;
  final bool darkMode;

  const AppSettings({
    this.globalMessage =
        "Happy birthday, {name}! 🎂🎉 Hope you're having an incredible day!",
    this.notificationTime = const TimeOfDay(hour: 9, minute: 0),
    this.enableNotifications = false,
    this.advanceNotice = false,
    this.darkMode = false,
  });

  AppSettings copyWith({
    String? globalMessage,
    TimeOfDay? notificationTime,
    bool? enableNotifications,
    bool? advanceNotice,
    bool? darkMode,
  }) {
    return AppSettings(
      globalMessage: globalMessage ?? this.globalMessage,
      notificationTime: notificationTime ?? this.notificationTime,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      advanceNotice: advanceNotice ?? this.advanceNotice,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}

class AppSettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() => const AppSettings();

  void setAdvanceNotice(bool value) =>
      state = state.copyWith(advanceNotice: value);

  void setDarkMode(bool value) => state = state.copyWith(darkMode: value);

  void setEnableNotifications(bool value) =>
      state = state.copyWith(enableNotifications: value);

  void setGlobalMessage(String message) =>
      state = state.copyWith(globalMessage: message);

  void setNotificationTime(TimeOfDay time) =>
      state = state.copyWith(notificationTime: time);
}
