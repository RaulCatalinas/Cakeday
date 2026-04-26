import 'package:cakeday/components/layout/main_tab_scaffold.dart'
    show MainTabScaffold;
import 'package:cakeday/db/db_manager.dart';
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/screens/all_birthdays.dart';
import 'package:cakeday/screens/home.dart' show HomeScreen;
import 'package:cakeday/screens/settings.dart';
import 'package:cakeday/types/nav_item.dart' show NavItem;
import 'package:cakeday/utils/notifications.dart'
    show initializeNotifications, setupNotificationListeners;
import 'package:cakeday/utils/preferences.dart' show Preferences;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Icons,
        StatelessWidget,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;
import 'package:flutter_themed/flutter_themed.dart'
    show ThemeStorageAdapter, Themed;
import 'package:flutter_themed/themed_app.dart' show ThemedApp;
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();
  await Future.wait([
    DbManager.init(),
    Themed.initialize(storageAdapter: AppThemeStorageAdapter()),
    initializeDateFormatting('en'),
    initializeDateFormatting('es'),
    initializeNotifications(),
  ]);

  setupNotificationListeners();

  runApp(const ProviderScope(child: MyApp()));
}

class AppThemeStorageAdapter implements ThemeStorageAdapter {
  @override
  Future<String?> loadTheme() async {
    final isDark = Preferences.getDarkMode();

    if (isDark == null) return null;

    return isDark ? 'dark' : 'light';
  }

  @override
  Future<void> saveTheme(String themeName) =>
      Preferences.saveDarkMode(themeName == 'dark');
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTabScaffold(
      tabs: [
        NavItem(
          screen: const HomeScreen(),
          label: AppLocalizations.of(context)!.home_tab_label,
          icon: Icons.cake,
        ),
        NavItem(
          screen: const AllBirthdaysScreen(),
          label: AppLocalizations.of(context)!.all_birthdays_header,
          icon: Icons.people,
        ),
        NavItem(
          screen: const SettingsScreen(),
          label: AppLocalizations.of(context)!.settings_tab_label,
          icon: Icons.settings,
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ThemedApp(
      title: 'Cakeday',
      home: MainScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
