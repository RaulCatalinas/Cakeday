import 'package:flutter/material.dart'
    show BuildContext, Color, StatelessWidget, Widget, TextStyle, Text;

class Subtitle extends StatelessWidget {
  final String text;

  const Subtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12, color: Color(0xFF6E6E73)),
    );
  }
}
