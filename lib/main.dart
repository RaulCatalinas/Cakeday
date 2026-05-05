import 'package:cakeday/components/layout/main_tab_scaffold.dart'
    show MainTabScaffold;
import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/managers/language_manager.dart' show LanguageManager;
import 'package:cakeday/screens/all_birthdays.dart' show AllBirthdaysScreen;
import 'package:cakeday/screens/home.dart' show HomeScreen;
import 'package:cakeday/screens/settings.dart' show SettingsScreen;
import 'package:cakeday/types/nav_item.dart' show NavItem;
import 'package:cakeday/utils/notifications.dart'
    show initializeNotifications, setupNotificationListeners;
import 'package:cakeday/utils/preferences.dart' show Preferences;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Icons,
        Locale,
        State,
        StatefulWidget,
        StatelessWidget,
        Widget,
        WidgetsBindingObserver,
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

  await setupNotificationListeners();

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
          label: AppLocalizations.of(context)!.all_birthdays_tab_label,
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Locale _locale;

  @override
  Widget build(BuildContext context) {
    return ThemedApp(
      title: 'Cakeday',
      home: const MainScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
    );
  }

  @override
  void initState() {
    super.initState();

    _locale = LanguageManager.getLocale();
    LanguageManager.setLanguageChangeCallback(_onLanguageChanged);
  }

  void _onLanguageChanged() {
    setState(() {
      _locale = LanguageManager.getLocale();
    });
  }
}
