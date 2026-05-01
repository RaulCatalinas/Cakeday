import 'package:cakeday/screens/add_birthday.dart' show AddBirthdayScreen;
import 'package:flutter/material.dart'
    show
        BuildContext,
        FloatingActionButton,
        Icon,
        Icons,
        MaterialPageRoute,
        Navigator,
        StatelessWidget,
        Widget;

class CreateBirthdayButton extends StatelessWidget {
  const CreateBirthdayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      enableFeedback: true,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddBirthdayScreen()),
      ),
      child: const Icon(Icons.add),
    );
  }
}
