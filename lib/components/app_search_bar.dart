import 'package:flutter/material.dart'
    show BuildContext, SearchBar, StatelessWidget, TextInputType, Widget;

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const AppSearchBar({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.keyboardType = .text,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      onChanged: onChanged,
      hintText: hintText,
      keyboardType: keyboardType,
    );
  }
}
