import 'dart:async' show Timer;

import 'package:ensure_visible_when_focused/ensure_visible_when_focused.dart'
    show EnsureVisibleWhenFocused;
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
  final int? maxLength;
  final bool autocorrect;
  final Color borderColor;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const Input({
    super.key,
    required this.hintText,
    this.onChanged,
    this.maxLines = 1,
    this.autocorrect = true,
    this.borderColor = const Color(0x00000000),
    this.keyboardType,
    this.focusNode,
    this.controller,
    this.maxLength,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late final TextEditingController _controller;
  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    return widget.focusNode != null
        ? EnsureVisibleWhenFocused(
            focusNode: widget.focusNode!,
            alignment: 0.5,
            alwaysAlign: true,
            child: _getCommonChild(),
          )
        : _getCommonChild();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();

    debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
  }

  Widget _getCommonChild() {
    return TextField(
      controller: _controller,
      autocorrect: true,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      onChanged: _onChanged,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
        ),
        hintText: widget.hintText,
      ),
    );
  }

  void _onChanged(String value) {
    debounce?.cancel();
    debounce = Timer(
      const Duration(milliseconds: 500),
      () => widget.onChanged?.call(value),
    );
  }
}
