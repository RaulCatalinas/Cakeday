import 'dart:ui' show PlatformDispatcher;

import 'package:cakeday/constants/languages.dart';
import 'package:cakeday/utils/preferences.dart' show Preferences;
import 'package:flutter/material.dart' show Locale, VoidCallback;

class LanguageManager {
  static final _instance = LanguageManager._internal();
  static VoidCallback? _onLanguageChanged;
  static final _osLanguage = PlatformDispatcher.instance.locale.languageCode;

  factory LanguageManager() {
    return _instance;
  }

  LanguageManager._internal();

  static Future<void> changeLanguage(String languageCode) async {
    await Preferences.saveLanguage(languageCode);

    _onLanguageChanged?.call();
  }

  static Locale getLocale() {
    final prefsLanguage = Preferences.getLanguage();

    return switch (prefsLanguage) {
      null => _getDefaultLocale(),
      'os' => Locale(_osLanguage),
      _ => Locale(prefsLanguage),
    };
  }

  static String getRawLocale() {
    final prefsLanguage = Preferences.getLanguage();

    return switch (prefsLanguage) {
      null => _getDefaultLocale().languageCode,
      'os' => Locale(_osLanguage).languageCode,
      _ => Locale(prefsLanguage).languageCode,
    };
  }

  static void setLanguageChangeCallback(VoidCallback callback) {
    _onLanguageChanged = callback;
  }

  static Locale _getDefaultLocale() {
    return switch (availableLocales.contains(_osLanguage)) {
      false => const Locale('en'),
      true => Locale(_osLanguage),
    };
  }
}
