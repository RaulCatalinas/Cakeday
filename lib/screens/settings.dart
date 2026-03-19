import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Column,
        EdgeInsets,
        Padding,
        Scaffold,
        StatelessWidget,
        Widget,
        Icon,
        Icons;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [Icon(Icons.settings)],
          ),
        ),
      ),
    );
  }
}
