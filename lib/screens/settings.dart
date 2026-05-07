import 'package:cakeday/components/birthday/select_reminder_hour.dart'
    show SelectReminderHour;
import 'package:cakeday/components/common/app_card.dart' show AppCard;
import 'package:cakeday/components/common/app_dropdown.dart' show AppDropdown;
import 'package:cakeday/components/common/app_switch.dart' show AppSwitch;
import 'package:cakeday/components/common/section_title.dart' show SectionTitle;
import 'package:cakeday/components/common/subtitle.dart' show Subtitle;
import 'package:cakeday/components/layout/preview_message.dart'
    show PreviewMessage;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/managers/language_manager.dart' show LanguageManager;
import 'package:cakeday/permissions/notifications.dart'
    show requestNotificationsPermission;
import 'package:cakeday/providers/settings_provider.dart'
    show appSettingsProvider;
import 'package:cakeday/utils/preferences.dart' show Preferences;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        Divider,
        DropdownMenuEntry,
        Expanded,
        Icon,
        Icons,
        LayoutBuilder,
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

    return Scaffold(
      body: SafeArea(
        minimum: .all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SectionTitle(
                text: AppLocalizations.of(
                  context,
                )!.general_message_section_title,
              ),
              AppCard(
                child: PreviewMessage(
                  onChanged: (value) async =>
                      await notifier.setGlobalMessage(value),
                ),
              ),

              const SizedBox(height: 16),
              SectionTitle(
                text: AppLocalizations.of(context)!.notifications_section_title,
              ),
              AppCard(
                borderRadius: .vertical(top: .circular(25)),
                child: Row(
                  children: [
                    const Icon(Icons.notifications),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.enable_notifications,
                          ),
                          Subtitle(
                            text: AppLocalizations.of(
                              context,
                            )!.enable_notifications_subtitle,
                          ),
                        ],
                      ),
                    ),
                    AppSwitch(
                      defaultValue: settings.enableNotifications,
                      preOnChanged: () async {
                        final status = await requestNotificationsPermission(
                          context: context,
                        );
                        return status.isGranted;
                      },
                      onChanged: (value) async =>
                          await notifier.setEnableNotifications(value),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, height: 1),
              SelectReminderHour(
                onSelectedHour: (time) async =>
                    await notifier.setNotificationTime(time),
                borderRadius: .zero,
                initialHour: settings.notificationTime,
              ),
              const Divider(thickness: 1, height: 1),
              AppCard(
                borderRadius: .vertical(bottom: .circular(25)),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(AppLocalizations.of(context)!.advance_notice),
                          Subtitle(
                            text: AppLocalizations.of(
                              context,
                            )!.advance_notice_subtitle,
                          ),
                        ],
                      ),
                    ),
                    AppSwitch(
                      defaultValue: settings.advanceNotice,
                      onChanged: (value) async =>
                          await notifier.setAdvanceNotice(value),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              SectionTitle(
                text: AppLocalizations.of(context)!.appearance_section_title,
              ),
              AppCard(
                borderRadius: .vertical(top: .circular(25)),
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode_outlined),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(AppLocalizations.of(context)!.dark_mode),
                          Subtitle(
                            text: AppLocalizations.of(
                              context,
                            )!.dark_mode_subtitle,
                          ),
                        ],
                      ),
                    ),
                    AppSwitch(
                      defaultValue: Preferences.getDarkMode() ?? false,
                      onChanged: (value) async {
                        await Preferences.saveDarkMode(value);
                        Themed.toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, height: 1),
              AppCard(
                borderRadius: .vertical(bottom: .circular(25)),
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.language),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.change_language,
                                ),
                                Subtitle(
                                  text: AppLocalizations.of(
                                    context,
                                  )!.change_language_subtitle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AppDropdown(
                        initialValue: LanguageManager.getLanguageCode(),
                        width: constraints.maxWidth,
                        hintText: AppLocalizations.of(
                          context,
                        )!.change_language_hint_text,
                        dropdownMenuEntries: [
                          DropdownMenuEntry(
                            value: 'en',
                            label: AppLocalizations.of(
                              context,
                            )!.english_language,
                          ),
                          DropdownMenuEntry(
                            value: 'es',
                            label: AppLocalizations.of(
                              context,
                            )!.spanish_language,
                          ),
                          DropdownMenuEntry(
                            value: 'os',
                            label: AppLocalizations.of(context)!.os_language,
                          ),
                        ],
                        onSelected: (value) {
                          if (value == null) return;

                          LanguageManager.changeLanguage(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
