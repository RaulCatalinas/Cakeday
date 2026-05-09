import 'package:dropdown_button2/dropdown_button2.dart'
    show DropdownButtonFormField2, DropdownItem, DropdownStyleData;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Container,
        InputDecoration,
        State,
        StatefulWidget,
        Widget,
        OutlineInputBorder,
        ValueNotifier;

class AppDropdown<T> extends StatefulWidget {
  final List<DropdownItem<T>> dropdownMenuEntries;
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
  late final ValueNotifier<T?> valueNotifier;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return Container();
    }

    return DropdownButtonFormField2<T>(
      valueListenable: valueNotifier,
      alignment: .topCenter,
      items: widget.dropdownMenuEntries,
      isExpanded: true,
      dropdownStyleData: DropdownStyleData(width: widget.width),
      enableFeedback: true,
      onChanged: _onSelected,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(borderRadius: .all(.circular(25))),
      ),
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
    valueNotifier = ValueNotifier(widget.initialValue);
  }

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void _onSelected(T? value) {
    valueNotifier.value = value;

    widget.onSelected?.call(value);
  }
}
