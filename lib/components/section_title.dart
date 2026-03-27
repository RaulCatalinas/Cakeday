import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Text, TextStyle, Widget, Padding, Color;

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(left: 4, bottom: 8, top: 16),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: .w700,
          letterSpacing: 1.5,
          color: Color(0xFFAEAEB2),
        ),
      ),
    );
  }
}
