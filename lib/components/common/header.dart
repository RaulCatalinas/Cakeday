import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Text, TextStyle, Widget;

class Header extends StatelessWidget {
  final String text;
  final double fontSize;

  const Header({super.key, required this.text, this.fontSize = 18.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: .bold, fontSize: fontSize),
    );
  }
}
