import 'package:cakeday/components/common/selection_action_bar.dart'
    show SelectionActionBar;
import 'package:cakeday/providers/selection_provider.dart'
    show selectionProvider;
import 'package:cakeday/types/nav_item.dart' show NavItem;
import 'package:flutter/material.dart'
    show
        BottomNavigationBar,
        BottomNavigationBarItem,
        BuildContext,
        Icon,
        PopScope,
        Positioned,
        Scaffold,
        Stack,
        Theme,
        Widget;
import 'package:flutter/services.dart' show SystemNavigator;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget;

class MainTabScaffold extends ConsumerStatefulWidget {
  final List<NavItem> tabs;

  const MainTabScaffold({super.key, required this.tabs});

  @override
  ConsumerState<MainTabScaffold> createState() => _MainTabScaffoldState();
}

class _MainTabScaffoldState extends ConsumerState<MainTabScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isInMultiSelectMode = ref.watch(selectionProvider).multiSelectMode;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        final shouldPop = await _onPopInvoked();

        if (shouldPop && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            widget.tabs[_currentIndex].screen,
            if (isInMultiSelectMode && _currentIndex == 1)
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SelectionActionBar(),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          enableFeedback: true,
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
      setState(() => _currentIndex--);
      return false;
    }

    return true;
  }
}
