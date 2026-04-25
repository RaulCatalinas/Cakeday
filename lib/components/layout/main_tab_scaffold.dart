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
        Theme,
        Widget;

class MainTabScaffold extends StatefulWidget {
  final List<Widget> tabs;

  const MainTabScaffold({super.key, required this.tabs});

  @override
  State<MainTabScaffold> createState() => _MainTabScaffoldState();
}

class _MainTabScaffoldState extends State<MainTabScaffold> {
  int _currentIndex = 0;

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
        body: widget.tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
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
