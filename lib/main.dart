import 'package:cakeday/screens/all_birthdays.dart' show AllBirthdaysScreen;
import 'package:cakeday/screens/home.dart' show HomeScreen;
import 'package:cakeday/screens/settings.dart' show SettingsScreen;
import 'package:flutter/material.dart'
    show
        BottomNavigationBar,
        BottomNavigationBarItem,
        BuildContext,
        Icon,
        Icons,
        Navigator,
        PopScope,
        Scaffold,
        State,
        StatefulWidget,
        StatelessWidget,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:flutter_themed/themed_app.dart' show ThemedApp;
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en');
  runApp(const MyApp());
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedApp(title: 'Cakeday', home: MainScreen());
  }
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    AllBirthdaysScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldPop = await _onPopInvoked();

        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'All birthdays',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onPopInvoked() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);

      return false;
    }

    return true;
  }
}
