import 'package:cakeday/components/app_card.dart' show AppCard;
import 'package:cakeday/components/app_checkbox.dart' show AppCheckbox;
import 'package:cakeday/components/clickable_card.dart' show ClickableCard;
import 'package:cakeday/components/gradient_button.dart' show GradientButton;
import 'package:cakeday/components/header.dart' show Header;
import 'package:cakeday/components/input.dart' show Input;
import 'package:cakeday/components/reminder_card.dart' show ReminderCard;
import 'package:cakeday/components/section_title.dart' show SectionTitle;
import 'package:cakeday/handlers/handle_save_birthday.dart';
import 'package:cakeday/types/birthday_data.dart';
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:cakeday/utils/contacts_list.dart'
    show pickContact, requestContactListPermission;
import 'package:cakeday/utils/date.dart' show selectDate;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        Column,
        Divider,
        FocusNode,
        Icon,
        IconButton,
        Icons,
        Localizations,
        Navigator,
        Padding,
        Row,
        SafeArea,
        Scaffold,
        ScrollController,
        SingleChildScrollView,
        SizedBox,
        Spacer,
        State,
        StatefulWidget,
        Text,
        Visibility,
        Widget;
import 'package:intl/intl.dart' show DateFormat;
import 'package:permission_handler/permission_handler.dart';

class AddBirthdayScreen extends StatefulWidget {
  const AddBirthdayScreen({super.key});

  @override
  State<AddBirthdayScreen> createState() => _AddBirthdayScreenState();
}

class _AddBirthdayScreenState extends State<AddBirthdayScreen> {
  ContactInfo contactInfo;
  DateTime? birthday;
  bool usePersonalizedMessage = false;
  bool useNote = false;
  bool includeYear = false;

  final messageFocusNode = FocusNode();
  final noteFocusNode = FocusNode();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final formattedMonthAndDay = birthday != null
        ? DateFormat.MMMMd(locale).format(birthday!)
        : 'Unknown';
    final formattedYear = birthday != null
        ? DateFormat.y(locale).format(birthday!)
        : 'Optional';

    return Scaffold(
      body: SafeArea(
        minimum: .all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Row(
                children: [
                  IconButton(
                    enableFeedback: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_circle_left, size: 28),
                  ),
                  const Header(text: 'Add birthday', fontSize: 18.0),
                ],
              ),
              const SectionTitle(text: 'Information'),
              ClickableCard(
                color: const Color(0x1AFF6B6B),
                onTap: () async {
                  final status = await requestContactListPermission();

                  if (!status.isGranted && !status.isLimited) return;

                  final result = await pickContact();

                  print('Phone number: ${result?.$2}');

                  setState(() => contactInfo = result);
                },
                child: const Row(
                  children: [
                    Icon(Icons.person),
                    Padding(padding: .directional(start: 8, end: 8)),
                    Text('Select from the contacts list'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),
              const Padding(padding: .directional(top: 8, bottom: 8)),
              ReminderCard(contactInfo: contactInfo),

              const SectionTitle(text: 'Date'),
              ClickableCard(
                color: const Color(0xffffffff),
                borderRadius: .vertical(top: .circular(25.0)),
                onTap: () async {
                  final date = await selectDate(context: context);

                  setState(() {
                    birthday = date;
                  });
                },
                child: Row(
                  children: [
                    const Icon(Icons.cake),
                    const Padding(padding: .directional(start: 8, end: 8)),
                    const Text('Date'),
                    const Padding(padding: .symmetric(horizontal: 16)),
                    Text(formattedMonthAndDay),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),
              const Divider(thickness: 1, height: 1, color: Color(0xFFE5E5EA)),
              ClickableCard(
                color: const Color(0xffffffff),
                borderRadius: .vertical(bottom: .circular(25.0)),
                onTap: () async {
                  final date = await selectDate(context: context);

                  setState(() {
                    birthday = date;
                  });
                },
                child: Row(
                  children: [
                    const Icon(Icons.card_giftcard),
                    const Padding(padding: .symmetric(horizontal: 8)),
                    const Text('Year of birth'),
                    AppCheckbox(
                      onChanged: (value) => setState(() => includeYear = value),
                    ),
                    const Padding(padding: .symmetric(horizontal: 16)),
                    Text(includeYear ? formattedYear : 'Optional'),
                  ],
                ),
              ),

              const SectionTitle(text: 'Message'),
              AppCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline),
                        const Padding(padding: .symmetric(horizontal: 15)),
                        const Text('Personalized message'),
                        AppCheckbox(
                          onChanged: (value) {
                            setState(() => usePersonalizedMessage = value);

                            if (value) messageFocusNode.requestFocus();
                          },
                        ),
                      ],
                    ),
                    const Padding(padding: .symmetric(vertical: 8)),
                    Visibility(
                      visible: usePersonalizedMessage,
                      child: SizedBox(
                        height: 100,
                        child: Input(
                          focusNode: messageFocusNode,
                          hintText: 'Personalized birthday message',
                          maxLines: 3,
                          keyboardType: .multiline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SectionTitle(text: 'Note'),
              AppCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.edit_note),
                        const Padding(padding: .symmetric(horizontal: 15)),
                        const Text('Note'),
                        AppCheckbox(
                          onChanged: (value) {
                            setState(() => useNote = value);

                            if (value) noteFocusNode.requestFocus();
                          },
                        ),
                      ],
                    ),
                    const Padding(padding: .symmetric(vertical: 8)),
                    Visibility(
                      visible: useNote,
                      child: SizedBox(
                        height: 100,
                        child: Input(
                          focusNode: noteFocusNode,
                          hintText: 'E.g.: He likes coffee',
                          maxLines: 3,
                          keyboardType: .multiline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(padding: .symmetric(vertical: 15)),
              GradientButton(
                label: 'Save birthday',
                colors: const [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                onTap: () async {
                  final birthdayData = BirthdayData(
                    contactInfo: contactInfo,
                    birthday: birthday,
                    includeYear: includeYear,
                  );

                  await handleSaveBirthday(birthdayData: birthdayData);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageFocusNode.dispose();
    noteFocusNode.dispose();
    super.dispose();
  }
}
