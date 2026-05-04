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
  String get information_section_title => 'Contact';

  @override
  String get select_contact => 'Choose from your contacts';

  @override
  String get date_section_title => 'Birthday';

  @override
  String get year_of_birth => 'Birth year';

  @override
  String get message => 'Message';

  @override
  String get personalized_message => 'Custom message';

  @override
  String get personalized_message_input_hint_text =>
      'Write a personal birthday message…';

  @override
  String get note_section_title => 'Note';

  @override
  String get note_input_hint_text => 'E.g.: She loves chocolate cake';

  @override
  String get optional_text => 'Optional';

  @override
  String get all_birthdays_header => 'All birthdays';

  @override
  String get app_search_bar_hint_text => 'Search by name or date…';

  @override
  String get could_not_load_birthdays_error =>
      'We couldn\'t load your birthdays. Pull down to try again.';

  @override
  String get not_birthdays_yet_information =>
      'No birthdays yet.\nTap the + button to add your first one!';

  @override
  String get no_search_matches_error =>
      'No results found.\nTry a different name or month.';

  @override
  String get general_message_section_title => 'Birthday message';

  @override
  String get notifications_section_title => 'Reminders';

  @override
  String get enable_notifications => 'Enable reminders';

  @override
  String get enable_notifications_subtitle =>
      'Get notified on the day of the birthday';

  @override
  String get notification_time => 'Reminder time';

  @override
  String get notification_time_subtitle =>
      'You\'ll be notified at this time every year';

  @override
  String get advance_notice => 'Early reminder';

  @override
  String get advance_notice_subtitle => 'Also notify me the day before';

  @override
  String get appearance_section_title => 'Appearance';

  @override
  String get dark_mode => 'Dark mode';

  @override
  String get dark_mode_subtitle => 'Switch between light and dark theme';

  @override
  String get global_birthday_input_hint_text =>
      'Write your default birthday message…';

  @override
  String get default_global_message =>
      'Happy birthday, {name}! 🎂🎉 Hope you\'re having an incredible day!';

  @override
  String count_birthday_message_chars(int count) {
    return '$count characters · 10 minimum';
  }

  @override
  String get name_placeholder_info =>
      'will be replaced with your contact\'s name when you open WhatsApp';

  @override
  String get cancel_button_text => 'Cancel';

  @override
  String get empty_birthday_message_error =>
      'Please write a birthday message before saving.';

  @override
  String get too_short_birthday_error =>
      'Your message is a bit short. Write at least 10 characters.';

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

  @override
  String get all_birthdays_tab_label => 'Birthdays';

  @override
  String get unknown_text => 'Unknown';

  @override
  String get change_language => 'App language';

  @override
  String get spanish_language => 'Spanish';

  @override
  String get english_language => 'English';

  @override
  String get change_language_subtitle => 'Choose the language you prefer';

  @override
  String get change_language_hint_text => 'Select a language';

  @override
  String get os_language => 'Use device language';

  @override
  String get getting_birthdays_error =>
      'We couldn\'t load your birthdays. Please try again.';

  @override
  String get empty_birthdays_error =>
      'You haven\'t added any birthdays yet.\nTap + to get started!';

  @override
  String get save_birthday_reminder_button_text => 'Save birthday';

  @override
  String get no_contact_selected_error => 'Please choose a contact first.';

  @override
  String get no_contact_phone_error =>
      'We couldn\'t find a phone number for this contact. Please try a different one.';

  @override
  String get no_birthday_date_error => 'Please select the birthday date.';

  @override
  String get birthday_save_error => 'Something went wrong. Please try again.';

  @override
  String get reminder_configured_successfully =>
      'Reminder set! You\'ll be notified on the big day 🎂';

  @override
  String get birthday_saved => 'Birthday saved! 🎂';

  @override
  String get reminder_configuration_failed =>
      'Birthday saved, but we couldn\'t set the reminder. Go to Settings to enable notifications.';

  @override
  String get birthday_deleted_success => 'Reminder deleted.';

  @override
  String get birthday_deleted_error =>
      'We couldn\'t delete the reminder. Please try again.';

  @override
  String get notification_could_not_be_scheduled =>
      'We couldn\'t set the reminder for this birthday.';

  @override
  String get retry_text => 'Try again';

  @override
  String get delete_text => 'Delete';

  @override
  String get confirm_delete_birthday_dialog_content =>
      'Are you sure you want to delete this reminder? This can\'t be undone.';

  @override
  String get cancel_text => 'Cancel';

  @override
  String get today_text => 'Today';

  @override
  String get tomorrow_text => 'Tomorrow';

  @override
  String turns_age(int age) {
    return 'Turns $age';
  }

  @override
  String days_remaining(int days) {
    return 'In $days days';
  }

  @override
  String weeks_remaining(int weeks) {
    return 'In $weeks weeks';
  }

  @override
  String months_remaining(int months) {
    return 'In $months months';
  }

  @override
  String years_remaining(int years) {
    return 'In $years years';
  }

  @override
  String years_and_months_remaining(int years, int months) {
    return 'In $years years and $months months';
  }

  @override
  String get no_birthdays_today => 'No birthdays today 🎂';

  @override
  String get no_upcoming_birthdays =>
      'No birthdays coming up in the next 30 days.';

  @override
  String get birthday_already_exists =>
      'You already have a reminder for this person.';

  @override
  String get today_birthdays_section_title => 'Today';

  @override
  String get upcoming_birthdays_section_title => 'Coming up';

  @override
  String get update_birthday_error =>
      'We couldn\'t save your changes. Please try again.';

  @override
  String get update_birthday_success => 'Birthday updated! 🎂';

  @override
  String get reminder_updated_successfully => 'Reminder updated! 🎂';

  @override
  String get reminder_update_failed =>
      'We couldn\'t update the reminder. Go to Settings to check your notification permissions.';

  @override
  String get birthday_reminder_title => '🎂 Birthday today!';

  @override
  String birthday_reminder_body(String name) {
    return 'Today is $name\'s birthday! Tap to send your wishes 🎉';
  }

  @override
  String get contacts_permission_denied =>
      'To add birthdays quickly, allow Cakeday to access your contacts in Settings.';

  @override
  String get contacts_permission_permanently_denied =>
      'Contacts access is blocked. You can enable it in your phone\'s Settings.';

  @override
  String get contacts_permission_limited =>
      'You\'ve only shared some contacts. Some people may not appear in the list.';

  @override
  String get contacts_permission_restricted =>
      'Your device doesn\'t allow access to contacts. Check your parental controls or device settings.';

  @override
  String get notifications_permission_denied =>
      'Allow notifications so Cakeday can remind you on birthdays.';

  @override
  String get notifications_permission_permanently_denied =>
      'Notifications are turned off. You can enable them in your phone\'s Settings.';

  @override
  String get notifications_permission_restricted =>
      'Your device doesn\'t allow notifications. Check your parental controls or device settings.';
}
