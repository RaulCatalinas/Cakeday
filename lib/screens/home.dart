import 'package:cakeday/components/create_birthday_button.dart'
    show CreateBirthdayButton;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Column,
        EdgeInsets,
        Icon,
        Icons,
        Padding,
        Scaffold,
        StatelessWidget,
        Widget;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [const Icon(Icons.cake)],
          ),
        ),
      ),
      floatingActionButton: const CreateBirthdayButton(),
    );
  }
}
