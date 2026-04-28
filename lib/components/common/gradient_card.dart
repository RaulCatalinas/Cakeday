import 'package:flutter/material.dart'
    show
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Color,
        DecoratedBox,
        LinearGradient,
        Padding,
        StatelessWidget,
        Widget;

class GradientCard extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final BorderRadius borderRadius;
  final double padding;

  const GradientCard({
    super.key,
    required this.child,
    this.colors = const [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
    this.borderRadius = const .only(
      topLeft: .circular(14),
      topRight: .circular(14),
      bottomRight: .circular(4),
      bottomLeft: .circular(14),
    ),
    this.padding = 12,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: borderRadius,
      ),
      child: Padding(padding: .all(padding), child: child),
    );
  }
}
