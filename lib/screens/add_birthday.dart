import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Column,
        EdgeInsets,
        Padding,
        Scaffold,
        StatelessWidget,
        Text,
        Widget;

class AddBirthdayScreen extends StatelessWidget {
  const AddBirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [Text('Create birthday reminder')],
          ),
        ),
      ),
    );
  }
}
