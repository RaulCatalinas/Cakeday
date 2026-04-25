import 'package:flutter/material.dart'
    show BuildContext, Color, State, StatefulWidget, Switch, Widget;

class AppSwitch extends StatefulWidget {
  final Color activatedColor;
  final void Function(bool) onChanged;
  final Future<bool> Function()? preOnChanged;
  final bool defaultValue;

  const AppSwitch({
    super.key,
    required this.onChanged,
    this.activatedColor = const Color(0xff34C759),
    this.preOnChanged,
    this.defaultValue = false,
  });

  @override
  State<StatefulWidget> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  late bool activated;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: activated,
      activeTrackColor: widget.activatedColor,
      onChanged: (value) async {
        if (widget.preOnChanged != null) {
          final shouldContinue = await widget.preOnChanged!.call();

          if (!shouldContinue) return;
        }

        setState(() {
          activated = value;
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
