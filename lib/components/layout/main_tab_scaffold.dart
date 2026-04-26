import 'package:cakeday/types/nav_item.dart' show NavItem;
import 'package:flutter/material.dart'
    show
        BottomNavigationBar,
        BottomNavigationBarItem,
        BuildContext,
        Icon,
        Navigator,
        PopScope,
        Scaffold,
        State,
        StatefulWidget,
        Theme,
        Widget;

class MainTabScaffold extends StatefulWidget {
  final List<NavItem> tabs;

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
        body: widget.tabs[_currentIndex].screen,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          items: widget.tabs
              .map(
                (tab) => BottomNavigationBarItem(
                  icon: Icon(tab.icon),
                  label: tab.label,
                ),
              )
              .toList(),
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
