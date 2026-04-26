import 'package:flutter/material.dart'
    show
        BuildContext,
        Container,
        DropdownMenu,
        DropdownMenuEntry,
        State,
        StatefulWidget,
        Widget;

class AppDropdown<T> extends StatefulWidget {
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final void Function(T?)? onSelected;
  final bool initiallyVisible;
  final bool readOnly;
  final String hintText;
  final T? initialValue;
  final double width;

  const AppDropdown({
    super.key,
    this.initiallyVisible = true,
    this.initialValue,
    this.readOnly = true,
    this.width = double.infinity,
    required this.hintText,
    required this.dropdownMenuEntries,
    required this.onSelected,
  });

  @override
  State<AppDropdown<T>> createState() => AppDropdownState<T>();
}

class AppDropdownState<T> extends State<AppDropdown<T>> {
  late bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return Container();
    }

    return DropdownMenu<T>(
      width: widget.width,
      dropdownMenuEntries: widget.dropdownMenuEntries,
      onSelected: widget.onSelected,
      hintText: widget.hintText,
      initialSelection: widget.initialValue,
      enableFilter: !widget.readOnly,
      enableSearch: !widget.readOnly,
      requestFocusOnTap: !widget.readOnly,
    );
  }

  void closeIfOpen() {
    if (!isVisible) return;

    setState(() {
      isVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isVisible = widget.initiallyVisible;
  }

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }
}
