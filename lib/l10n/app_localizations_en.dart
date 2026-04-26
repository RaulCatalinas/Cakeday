// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get add_birthday_header => 'Add birthday';

  @override
  String get information_section_title => 'Information';

  @override
  String get select_contact => 'Select from the contacts list';

  @override
  String get date_section_title => 'Date';

  @override
  String get year_of_birth => 'Year of birth';

  @override
  String get message => 'Message';

  @override
  String get personalized_message => 'Personalized message';

  @override
  String get personalized_message_input_hint_text =>
      'Personalized birthday message';

  @override
  String get note_section_title => 'Note';

  @override
  String get note_input_hint_text => 'E.g.: He likes coffee';

  @override
  String get not_include_year_text => 'Optional';

  @override
  String get all_birthdays_header => 'All birthdays';

  @override
  String get app_search_bar_hint_text => 'Search for reminders';

  @override
  String get could_not_load_birthdays_error =>
      'We couldn\'t load your birthdays. Please try again in a moment.';

  @override
  String get not_birthdays_yet_information =>
      'No birthdays yet.\nAdd someone using the add screen.';

  @override
  String get no_search_matches_error =>
      'No reminders match your search.\nTry another name or date.';

  @override
  String get general_message_section_title => 'General message';

  @override
  String get notifications_section_title => 'Notifications';

  @override
  String get enable_notifications => 'Enable notifications';

  @override
  String get enable_notifications_subtitle =>
      'Alerts you on the day of the birthday';

  @override
  String get notification_time => 'Notification time';

  @override
  String get notification_time_subtitle => 'Repeats every year';

  @override
  String get advance_notice => 'Advance notice';

  @override
  String get advance_notice_subtitle => 'Also notify the day before';

  @override
  String get appearance_section_title => 'Appearance';

  @override
  String get dark_mode => 'Dark mode';

  @override
  String get dark_mode_subtitle => 'Switch between light and dark theme';

  @override
  String get global_birthday_input_hint_text => 'Birthday message';

  @override
  String get default_global_message =>
      'Happy birthday, {name}! 🎂🎉 Hope you\'re having an incredible day!';

  @override
  String count_birthday_message_chars(int count) {
    return '$count characters · minimum 10';
  }

  @override
  String get name_placeholder_info =>
      'will be replaced with the contact\'s name when opening WhatsApp';

  @override
  String get cancel_button_text => 'Cancel';

  @override
  String get empty_birthday_message_error =>
      'A birthday greeting shouldn\'t be empty';

  @override
  String get too_short_birthday_error => 'The message is too short';

  @override
  String get save_birthday_button_text => 'Save message';

  @override
  String get edit_message_button_text => 'Edit message';

  @override
  String get preview_whatsapp_text => 'PREVIEW · WHATSAPP';

  @override
  String get home_tab_label => 'Home';

  @override
  String get settings_tab_label => 'Settings';
}
