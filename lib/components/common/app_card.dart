import 'package:flutter/material.dart'
    show
        BorderRadiusGeometry,
        BorderSide,
        BuildContext,
        Card,
        Color,
        Padding,
        RoundedRectangleBorder,
        StatelessWidget,
        Widget;

class AppCard extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double padding;
  final Widget child;
  final bool isSelected;

  const AppCard({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding = 25.0,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: isSelected
            ? const BorderSide(color: Color(0xFFFF6B6B), width: 2)
            : .none,
        borderRadius: borderRadius ?? .circular(25.0),
      ),
      child: Padding(padding: .all(padding), child: child),
    );
  }
}
