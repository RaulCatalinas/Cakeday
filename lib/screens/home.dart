import 'package:cakeday/screens/add_birthday.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Column,
        EdgeInsets,
        FloatingActionButton,
        Icon,
        Icons,
        MaterialPageRoute,
        Navigator,
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
            children: [
              const Icon(Icons.cake),
              FloatingActionButton(
                enableFeedback: true,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddBirthdayScreen()),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
