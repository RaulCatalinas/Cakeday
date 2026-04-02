import 'package:cakeday/components/app_card.dart' show AppCard;
import 'package:cakeday/components/app_switch.dart' show AppSwitch;
import 'package:cakeday/components/preview_message.dart' show PreviewMessage;
import 'package:cakeday/components/section_title.dart' show SectionTitle;
import 'package:cakeday/components/subtitle.dart' show Subtitle;
import 'package:cakeday/permissions/notifications.dart'
    show requestNotificationsPermission;
import 'package:cakeday/providers/settings_provider.dart'
    show appSettingsProvider;
import 'package:cakeday/utils/preferences.dart' show Preferences;
import 'package:cakeday/utils/time.dart' show selectHour;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        Divider,
        Expanded,
        Icon,
        IconButton,
        Icons,
        MaterialLocalizations,
        Row,
        SafeArea,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        Text,
        Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerStatefulWidget, ConsumerState;
import 'package:flutter_themed/flutter_themed.dart' show Themed;
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);
    final notifier = ref.read(appSettingsProvider.notifier);

    final formattedTime = MaterialLocalizations.of(
      context,
    ).formatTimeOfDay(settings.notificationTime);

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
                  onChanged: (value) => notifier.setGlobalMessage(value),
                ),
              ),

              const SizedBox(height: 16),
              const SectionTitle(text: 'Notifications'),
              AppCard(
                borderRadius: .vertical(top: .circular(25)),
                child: Row(
                  children: [
                    const Icon(Icons.notifications),
                    const SizedBox(width: 8),
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
                      defaultValue: settings.enableNotifications,
                      preOnChanged: () async {
                        final status = await requestNotificationsPermission();
                        return status.isGranted;
                      },
                      onChanged: (value) =>
                          notifier.setEnableNotifications(value),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, height: 1),
              AppCard(
                borderRadius: .zero,
                child: Row(
                  children: [
                    const Icon(Icons.alarm),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text('Notification time'),
                          Subtitle(text: 'Repeats every year'),
                        ],
                      ),
                    ),
                    Text(formattedTime),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 20),
                      onPressed: () async {
                        final selectedHour = await selectHour(context: context);

                        if (selectedHour != null) {
                          notifier.setNotificationTime(selectedHour);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, height: 1),
              AppCard(
                borderRadius: .vertical(bottom: .circular(25)),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(width: 8),
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
                      defaultValue: settings.advanceNotice,
                      onChanged: (value) => notifier.setAdvanceNotice(value),
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
                    const SizedBox(width: 8),
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
                      defaultValue: Preferences.getDarkMode() ?? false,
                      onChanged: (value) {
                        Preferences.saveDarkMode(value);
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
}
