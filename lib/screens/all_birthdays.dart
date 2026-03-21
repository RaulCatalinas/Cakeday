import 'package:cakeday/screens/add_birthday.dart' show AddBirthdayScreen;
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
        SafeArea,
        Scaffold,
        StatelessWidget,
        Widget;

class AllBirthdaysScreen extends StatelessWidget {
  const AllBirthdaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddBirthdayScreen()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
