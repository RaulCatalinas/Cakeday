import 'dart:async';

import 'package:flutter/material.dart'
    show
        BorderSide,
        BuildContext,
        Color,
        FocusNode,
        InputDecoration,
        OutlineInputBorder,
        State,
        StatefulWidget,
        TextEditingController,
        TextField,
        TextInputType,
        Widget;

class Input extends StatefulWidget {
  final String hintText;
  final void Function(String value)? onChanged;
  final int maxLines;
  final bool autocorrect;
  final Color borderColor;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const Input({
    super.key,
    required this.hintText,
    this.onChanged,
    this.maxLines = 1,
    this.autocorrect = true,
    this.borderColor = const Color(0x00000000),
    this.keyboardType,
    this.focusNode,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late final TextEditingController controller;
  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: true,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      onChanged: _onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
        ),
        hintText: widget.hintText,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  void _onChanged(String value) {
    debounce?.cancel();
    debounce = Timer(
      const Duration(milliseconds: 500),
      () => widget.onChanged?.call(value),
    );
  }
}
