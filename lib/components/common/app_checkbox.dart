import 'package:flutter/material.dart'
    show BuildContext, Color, State, StatefulWidget, Checkbox, Widget;

class AppCheckbox extends StatefulWidget {
  final Color activatedColor;
  final void Function(bool) onChanged;
  final bool defaultValue;

  const AppCheckbox({
    super.key,
    required this.onChanged,
    this.activatedColor = const Color(0xff34C759),
    this.defaultValue = false,
  });

  @override
  State<StatefulWidget> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool activated;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: activated,
      activeColor: widget.activatedColor,
      onChanged: (value) {
        setState(() {
          activated = value!;

          widget.onChanged.call(value);
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    activated = widget.defaultValue;
  }
}
