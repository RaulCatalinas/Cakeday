import 'package:cakeday/components/app_card.dart' show AppCard;
import 'package:cakeday/components/app_switch.dart' show AppSwitch;
import 'package:cakeday/components/preview_message.dart';
import 'package:cakeday/components/section_title.dart' show SectionTitle;
import 'package:cakeday/components/subtitle.dart' show Subtitle;
import 'package:cakeday/permissions/notifications.dart'
    show requestNotificationsPermission;
import 'package:cakeday/utils/time.dart' show selectHour;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        Divider,
        Icon,
        IconButton,
        Icons,
        MaterialLocalizations,
        Padding,
        Row,
        SafeArea,
        Scaffold,
        SingleChildScrollView,
        State,
        StatefulWidget,
        Text,
        TimeOfDay,
        Widget,
        SizedBox,
        Expanded;
import 'package:flutter_themed/flutter_themed.dart' show Themed;
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? birthdayMessage;
  bool enableNotifications = false;
  TimeOfDay? hour;
  late bool darkMode;

  @override
  Widget build(BuildContext context) {
    final formatted = hour != null
        ? MaterialLocalizations.of(context).formatTimeOfDay(hour!)
        : 'Unknown';

    return Scaffold(
      body: SafeArea(
        minimum: .all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const SectionTitle(text: 'General message'),
              AppCard(
                child: PreviewMessage(
                  onChanged: (value) => setState(() => birthdayMessage = value),
                ),
              ),

              const SizedBox(height: 16),
              const SectionTitle(text: 'Notifications'),
              AppCard(
                borderRadius: .vertical(top: .circular(25)),
                child: Row(
                  children: [
                    const Icon(Icons.notifications),
                    const Padding(padding: .symmetric(horizontal: 8)),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text('Enable notifications'),
                          Subtitle(
                            text: 'Alerts you on the day of the birthday',
                          ),
                        ],
                      ),
                    ),
                    AppSwitch(
                      preOnChanged: () async {
                        final status = await requestNotificationsPermission();
                        return status.isGranted;
                      },
                      onChanged: (value) =>
                          setState(() => enableNotifications = value),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              AppCard(
                borderRadius: .zero,
                child: Row(
                  children: [
                    const Icon(Icons.alarm),
                    const Padding(padding: .symmetric(horizontal: 8)),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text('Notification time'),
                          Subtitle(text: 'Repeats every year'),
                        ],
                      ),
                    ),
                    Text(formatted),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 20),
                      onPressed: () async {
                        final selectedHour = await selectHour(context: context);
                        setState(() => hour = selectedHour);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(height: 0),
              AppCard(
                borderRadius: .vertical(bottom: .circular(25)),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    const Padding(padding: .symmetric(horizontal: 8)),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text('Advance notice'),
                          Subtitle(text: 'Also notify the day before'),
                        ],
                      ),
                    ),
                    AppSwitch(
                      onChanged: (value) =>
                          setState(() => enableNotifications = value),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const SectionTitle(text: 'Appearance'),
              AppCard(
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode_outlined),
                    const Padding(padding: .symmetric(horizontal: 8)),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text('Dark mode'),
                          Subtitle(text: 'Switch between light and dark theme'),
                        ],
                      ),
                    ),
                    AppSwitch(
                      defaultValue: darkMode,
                      onChanged: (value) {
                        setState(() => darkMode = value);
                        Themed.toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    darkMode = Themed.currentThemeName == 'dark';
  }
}
