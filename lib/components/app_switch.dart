import 'package:flutter/material.dart'
    show BuildContext, Color, State, StatefulWidget, Switch, Widget;

class AppSwitch extends StatefulWidget {
  final Color activatedColor;
  final void Function(bool) onChanged;

  const AppSwitch({
    super.key,
    required this.onChanged,
    this.activatedColor = const Color(0xff34C759),
  });

  @override
  State<StatefulWidget> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  bool activated = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: activated,
      activeTrackColor: widget.activatedColor,
      onChanged: (value) {
        setState(() {
          activated = value;

          widget.onChanged.call(value);
        });
      },
    );
  }
}
