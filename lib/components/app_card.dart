import 'package:flutter/material.dart'
    show
        BorderRadiusGeometry,
        BuildContext,
        Padding,
        RoundedRectangleBorder,
        StatelessWidget,
        Widget,
        Card;

class AppCard extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double padding;
  final Widget child;

  const AppCard({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? .circular(25.0),
      ),
      child: Padding(padding: .all(padding), child: child),
    );
  }
}
