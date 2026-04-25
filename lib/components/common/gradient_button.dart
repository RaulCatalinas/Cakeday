import 'package:flutter/material.dart'
    show
        BoxDecoration,
        BuildContext,
        Center,
        Color,
        Colors,
        DecoratedBox,
        InkWell,
        LinearGradient,
        Material,
        Padding,
        SizedBox,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;

class GradientButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final List<Color> colors;
  final double borderRadius;
  final double verticalPadding;

  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.colors,
    this.borderRadius = 25,
    this.verticalPadding = 15,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: .circular(borderRadius),
          ),
          child: InkWell(
            enableFeedback: true,
            onTap: onTap,
            borderRadius: .circular(borderRadius),
            child: Padding(
              padding: .symmetric(vertical: verticalPadding),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: .bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
