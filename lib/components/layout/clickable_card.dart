import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        Color,
        InkWell,
        Material,
        Padding,
        StatelessWidget,
        Widget;

class ClickableCard extends StatelessWidget {
  final void Function() onTap;
  final BorderRadius? borderRadius;
  final double padding;
  final Widget child;
  final Color? color;

  const ClickableCard({
    super.key,
    required this.onTap,
    required this.child,
    this.borderRadius,
    this.padding = 25.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: borderRadius ?? .circular(25.0),
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? .circular(25.0),
        child: Padding(padding: .all(padding), child: child),
      ),
    );
  }
}
