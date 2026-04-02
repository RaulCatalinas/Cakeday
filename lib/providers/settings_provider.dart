import 'package:cakeday/utils/preferences.dart' show Preferences;
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

  const AppSettings({
    this.globalMessage =
        "Happy birthday, {name}! 🎂🎉 Hope you're having an incredible day!",
    this.notificationTime = const TimeOfDay(hour: 9, minute: 0),
    this.enableNotifications = false,
    this.advanceNotice = false,
  });

  AppSettings copyWith({
    String? globalMessage,
    TimeOfDay? notificationTime,
    bool? enableNotifications,
    bool? advanceNotice,
  }) {
    return AppSettings(
      globalMessage: globalMessage ?? this.globalMessage,
      notificationTime: notificationTime ?? this.notificationTime,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      advanceNotice: advanceNotice ?? this.advanceNotice,
    );
  }
}

class AppSettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    return AppSettings(
      globalMessage:
          Preferences.getGlobalMessage() ??
          "Happy birthday, {name}! 🎂🎉 Hope you're having an incredible day!",
      notificationTime:
          Preferences.getNotificationTime() ??
          const TimeOfDay(hour: 9, minute: 0),
      enableNotifications: Preferences.getEnableNotifications() ?? false,
      advanceNotice: Preferences.getAdvanceNotice() ?? false,
    );
  }

  void setAdvanceNotice(bool value) {
    state = state.copyWith(advanceNotice: value);
    Preferences.saveAdvanceNotice(value);
  }

  void setEnableNotifications(bool value) {
    state = state.copyWith(enableNotifications: value);
    Preferences.saveEnableNotifications(value);
  }

  void setGlobalMessage(String message) {
    state = state.copyWith(globalMessage: message);
    Preferences.saveGlobalMessage(message);
  }

  void setNotificationTime(TimeOfDay time) {
    state = state.copyWith(notificationTime: time);
    Preferences.saveNotificationTime(time);
  }
}
