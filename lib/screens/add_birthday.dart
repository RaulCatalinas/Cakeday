import 'package:cakeday/components/birthday/reminder_card.dart'
    show ReminderCard;
import 'package:cakeday/components/common/app_card.dart' show AppCard;
import 'package:cakeday/components/common/app_checkbox.dart' show AppCheckbox;
import 'package:cakeday/components/common/gradient_button.dart'
    show GradientButton;
import 'package:cakeday/components/common/header.dart' show Header;
import 'package:cakeday/components/common/input.dart' show Input;
import 'package:cakeday/components/common/section_title.dart' show SectionTitle;
import 'package:cakeday/components/layout/clickable_card.dart'
    show ClickableCard;
import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/handlers/handle_save_birthday.dart'
    show handleSaveBirthday;
import 'package:cakeday/handlers/handle_schedule_notification.dart';
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/permissions/contacts.dart'
    show requestContactListPermission;
import 'package:cakeday/providers/birthdays_provider.dart'
    show birthdaysListProvider;
import 'package:cakeday/providers/settings_provider.dart'
    show appSettingsProvider;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:cakeday/utils/contacts_list.dart' show pickContact;
import 'package:cakeday/utils/date.dart' show selectDate;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        Column,
        Divider,
        Expanded,
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
        Text,
        TextEditingController,
        Theme,
        Visibility,
        Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerStatefulWidget, ConsumerState;
import 'package:intl/intl.dart' show DateFormat;
import 'package:permission_handler/permission_handler.dart';

class AddBirthdayScreen extends ConsumerStatefulWidget {
  final BirthdayData? birthdayToEdit;

  const AddBirthdayScreen({super.key, this.birthdayToEdit});

  @override
  ConsumerState<AddBirthdayScreen> createState() => _AddBirthdayScreenState();
}

class _AddBirthdayScreenState extends ConsumerState<AddBirthdayScreen> {
  ContactInfo? contactInfo;
  DateTime? birthday;
  bool usePersonalizedMessage = false;
  bool useNote = false;
  bool includeYear = false;

  final messageFocusNode = FocusNode();
  final noteFocusNode = FocusNode();
  final scrollController = ScrollController();
  final messageController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final formattedMonthAndDay = birthday != null
        ? DateFormat.MMMMd(locale).format(birthday!)
        : AppLocalizations.of(context)!.unknown_text;
    final formattedYear = birthday != null
        ? DateFormat.y(locale).format(birthday!)
        : AppLocalizations.of(context)!.optional_text;

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
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_circle_left, size: 28),
                  ),
                  Header(
                    text: AppLocalizations.of(context)!.add_birthday_header,
                    fontSize: 18.0,
                  ),
                ],
              ),
              const Padding(padding: .symmetric(vertical: 16)),

              SectionTitle(
                text: AppLocalizations.of(context)!.information_section_title,
              ),
              ClickableCard(
                color: const Color(0x33FF6B6B),
                onTap: () async {
                  final status = await requestContactListPermission();

                  if (!status.isGranted && !status.isLimited) return;

                  final result = await pickContact();

                  setState(() => contactInfo = result);
                },
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const Padding(padding: .symmetric(horizontal: 8)),
                    Expanded(
                      child: Text(AppLocalizations.of(context)!.select_contact),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),
              const Padding(padding: .symmetric(vertical: 8)),
              ReminderCard(
                contactInfo: contactInfo,
                showActionButtons: false,
                notificationScheduled:
                    widget.birthdayToEdit?.notificationScheduled ?? false,
              ),

              const Padding(padding: .symmetric(vertical: 16)),

              SectionTitle(
                text: AppLocalizations.of(context)!.date_section_title,
              ),
              ClickableCard(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: .vertical(top: .circular(25.0)),
                onTap: () async {
                  final date = await selectDate(context: context);
                  setState(() => birthday = date);
                },
                child: Row(
                  children: [
                    const Icon(Icons.cake),
                    const Padding(padding: .symmetric(horizontal: 8)),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.date_section_title,
                      ),
                    ),
                    Text(formattedMonthAndDay),
                    const Padding(padding: .symmetric(horizontal: 8)),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),
              const Divider(thickness: 1, height: 1),
              ClickableCard(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: .vertical(bottom: .circular(25.0)),
                onTap: () async {
                  final date = await selectDate(context: context);

                  setState(() => birthday = date);
                },
                child: Row(
                  children: [
                    const Icon(Icons.card_giftcard),
                    const Padding(padding: .symmetric(horizontal: 8)),
                    Expanded(
                      child: Text(AppLocalizations.of(context)!.year_of_birth),
                    ),
                    Text(
                      includeYear
                          ? formattedYear
                          : AppLocalizations.of(context)!.optional_text,
                    ),
                    AppCheckbox(
                      onChanged: (value) => setState(() => includeYear = value),
                    ),
                  ],
                ),
              ),

              const Padding(padding: .symmetric(vertical: 16)),

              SectionTitle(text: AppLocalizations.of(context)!.message),
              AppCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline),
                        const Padding(padding: .symmetric(horizontal: 8)),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.personalized_message,
                          ),
                        ),
                        AppCheckbox(
                          onChanged: (value) {
                            setState(() => usePersonalizedMessage = value);

                            if (value) messageFocusNode.requestFocus();
                          },
                        ),
                      ],
                    ),
                    Visibility(
                      visible: usePersonalizedMessage,
                      child: Column(
                        children: [
                          const Padding(padding: .symmetric(vertical: 8)),
                          SizedBox(
                            height: 100,
                            child: Input(
                              controller: messageController,
                              focusNode: messageFocusNode,
                              hintText: AppLocalizations.of(
                                context,
                              )!.personalized_message_input_hint_text,
                              maxLines: 3,
                              keyboardType: .multiline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(padding: .symmetric(vertical: 16)),

              SectionTitle(
                text: AppLocalizations.of(context)!.note_section_title,
              ),
              AppCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.edit_note),
                        const Padding(padding: .symmetric(horizontal: 8)),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.note_section_title,
                          ),
                        ),
                        AppCheckbox(
                          onChanged: (value) {
                            setState(() => useNote = value);

                            if (value) noteFocusNode.requestFocus();
                          },
                        ),
                      ],
                    ),
                    Visibility(
                      visible: useNote,
                      child: Column(
                        children: [
                          const Padding(padding: .symmetric(vertical: 8)),
                          SizedBox(
                            height: 100,
                            child: Input(
                              controller: noteController,
                              focusNode: noteFocusNode,
                              hintText: AppLocalizations.of(
                                context,
                              )!.note_input_hint_text,
                              maxLines: 3,
                              keyboardType: .multiline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(padding: .symmetric(vertical: 15)),

              GradientButton(
                label: AppLocalizations.of(
                  context,
                )!.save_birthday_reminder_button_text,
                colors: const [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                onTap: () async {
                  if (widget.birthdayToEdit == null) {
                    final existRecord = await DbManager.existsBirthday(
                      name: contactInfo!.name,
                      phone: contactInfo!.phone ?? '',
                    );

                    if (existRecord) {
                      showToast(
                        type: .error,
                        msg: AppLocalizations.of(
                          context,
                        )!.birthday_already_exists,
                      );

                      return;
                    }

                    final settings = ref.read(appSettingsProvider);

                    final birthdayData = BirthdayData(
                      contactInfo: contactInfo,
                      birthday: birthday,
                      includeYear: includeYear,
                      customMessage: _trimmedOrNull(
                        enabled: usePersonalizedMessage,
                        text: messageController.text,
                      ),
                      note: _trimmedOrNull(
                        enabled: useNote,
                        text: noteController.text,
                      ),
                    );

                    final (saved, id) = await handleSaveBirthday(
                      birthdayData: birthdayData,
                      notificationTime: settings.notificationTime,
                      globalMessage: settings.globalMessage,
                      enableNotifications: settings.enableNotifications,
                      context: context,
                    );

                    if (saved) {
                      ref.invalidate(birthdaysListProvider);

                      if (id == null) return;

                      await handleScheduleNotification(
                        birthdayData: birthdayData,
                        notificationTime: settings.notificationTime,
                        birthdayId: id,
                        globalMessage: settings.globalMessage,
                        context: context,
                      );
                    }

                    return;
                  }

                  print('Editing existing birthday...');
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
    messageController.dispose();
    noteController.dispose();
    messageFocusNode.dispose();
    noteFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.birthdayToEdit == null) return;

    final birthdayDateTime = DateTime(
      widget.birthdayToEdit!.birthday?.year ?? 0,
      widget.birthdayToEdit!.birthday!.month,
      widget.birthdayToEdit!.birthday!.day,
    );

    birthday = birthdayDateTime;

    usePersonalizedMessage = widget.birthdayToEdit!.customMessage != null;
    useNote = widget.birthdayToEdit!.note != null;
    includeYear =
        widget.birthdayToEdit!.birthday?.year != null &&
        widget.birthdayToEdit!.birthday?.year != 0;

    contactInfo = ContactInfo(
      name: widget.birthdayToEdit!.contactInfo!.name,
      phone: widget.birthdayToEdit!.contactInfo?.phone,
      photo: widget.birthdayToEdit!.contactInfo?.photo,
      birthday: birthdayDateTime,
    );

    if (widget.birthdayToEdit!.note != null) {
      noteController.text = widget.birthdayToEdit!.note!;
    }

    if (widget.birthdayToEdit!.customMessage != null) {
      messageController.text = widget.birthdayToEdit!.customMessage!;
    }
  }

  String? _trimmedOrNull({required bool enabled, required String text}) {
    if (!enabled) return null;

    final trimmed = text.trim();

    return trimmed.isEmpty ? null : trimmed;
  }
}
