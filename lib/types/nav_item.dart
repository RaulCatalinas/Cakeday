import 'package:flutter/material.dart' show IconData, Widget;

class NavItem {
  final Widget screen;
  final String label;
  final IconData icon;

  const NavItem({
    required this.screen,
    required this.label,
    required this.icon,
  });
}
