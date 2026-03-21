import 'package:cakeday/components/reminder_card.dart' show ReminderCard;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:cakeday/utils/contacts_list.dart'
    show pickContact, requestContactListPermission;
import 'package:cakeday/utils/date.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        ButtonStyle,
        Center,
        Color,
        Column,
        Icon,
        Icons,
        InkWell,
        Material,
        OutlinedButton,
        Padding,
        Row,
        SafeArea,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        Widget;
import 'package:permission_handler/permission_handler.dart';

class AddBirthdayScreen extends StatefulWidget {
  const AddBirthdayScreen({super.key});

  @override
  State<AddBirthdayScreen> createState() => _AddBirthdayScreenState();
}

class _AddBirthdayScreenState extends State<AddBirthdayScreen> {
  ContactInfo contactInfo;
  DateTime? birthdayDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: .all(25.0),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Material(
                  color: const Color(0x1AFF6B6B),
                  child: InkWell(
                    onTap: () async {
                      final status = await requestContactListPermission();

                      if (!status.isGranted && !status.isLimited) return;

                      final result = await pickContact();

                      setState(() => contactInfo = result);
                    },
                    borderRadius: .circular(12),
                    child: const Padding(
                      padding: .all(25.0),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Padding(padding: .directional(start: 8, end: 8)),
                          Text('Select from the contacts list'),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: .directional(top: 8, bottom: 8)),
                ReminderCard(
                  name: contactInfo?.$1,
                  birthdayDate: birthdayDate,
                  photo: contactInfo?.$3,
                ),
                const Padding(padding: .directional(top: 8, bottom: 8)),
                OutlinedButton(
                  style: const ButtonStyle(enableFeedback: true),
                  onPressed: () async {
                    final date = await selectDate(context: context);

                    setState(() {
                      birthdayDate = date;
                    });
                  },
                  child: const Text('Select Date'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
