import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @add_birthday_header.
  ///
  /// In en, this message translates to:
  /// **'Add birthday'**
  String get add_birthday_header;

  /// No description provided for @information_section_title.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information_section_title;

  /// No description provided for @select_contact.
  ///
  /// In en, this message translates to:
  /// **'Select from the contacts list'**
  String get select_contact;

  /// No description provided for @date_section_title.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date_section_title;

  /// No description provided for @year_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Year of birth'**
  String get year_of_birth;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @personalized_message.
  ///
  /// In en, this message translates to:
  /// **'Personalized message'**
  String get personalized_message;

  /// No description provided for @personalized_message_input_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Personalized birthday message'**
  String get personalized_message_input_hint_text;

  /// No description provided for @note_section_title.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note_section_title;

  /// No description provided for @note_input_hint_text.
  ///
  /// In en, this message translates to:
  /// **'E.g.: He likes coffee'**
  String get note_input_hint_text;

  /// No description provided for @optional_text.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional_text;

  /// No description provided for @all_birthdays_header.
  ///
  /// In en, this message translates to:
  /// **'All birthdays'**
  String get all_birthdays_header;

  /// No description provided for @app_search_bar_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Search for reminders'**
  String get app_search_bar_hint_text;

  /// No description provided for @could_not_load_birthdays_error.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'\'t load your birthdays. Please try again in a moment.'**
  String get could_not_load_birthdays_error;

  /// No description provided for @not_birthdays_yet_information.
  ///
  /// In en, this message translates to:
  /// **'No birthdays yet.\nAdd someone using the add screen.'**
  String get not_birthdays_yet_information;

  /// No description provided for @no_search_matches_error.
  ///
  /// In en, this message translates to:
  /// **'No reminders match your search.\nTry another name or date.'**
  String get no_search_matches_error;

  /// No description provided for @general_message_section_title.
  ///
  /// In en, this message translates to:
  /// **'General message'**
  String get general_message_section_title;

  /// No description provided for @notifications_section_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_section_title;

  /// No description provided for @enable_notifications.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get enable_notifications;

  /// No description provided for @enable_notifications_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Alerts you on the day of the birthday'**
  String get enable_notifications_subtitle;

  /// No description provided for @notification_time.
  ///
  /// In en, this message translates to:
  /// **'Notification time'**
  String get notification_time;

  /// No description provided for @notification_time_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Repeats every year'**
  String get notification_time_subtitle;

  /// No description provided for @advance_notice.
  ///
  /// In en, this message translates to:
  /// **'Advance notice'**
  String get advance_notice;

  /// No description provided for @advance_notice_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Also notify the day before'**
  String get advance_notice_subtitle;

  /// No description provided for @appearance_section_title.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance_section_title;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get dark_mode;

  /// No description provided for @dark_mode_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark theme'**
  String get dark_mode_subtitle;

  /// No description provided for @global_birthday_input_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Birthday message'**
  String get global_birthday_input_hint_text;

  /// No description provided for @default_global_message.
  ///
  /// In en, this message translates to:
  /// **'Happy birthday, \'{name}\'! 🎂🎉 Hope you\'\'re having an incredible day!'**
  String get default_global_message;

  /// No description provided for @count_birthday_message_chars.
  ///
  /// In en, this message translates to:
  /// **'{count} characters · minimum 10'**
  String count_birthday_message_chars(int count);

  /// No description provided for @name_placeholder_info.
  ///
  /// In en, this message translates to:
  /// **'will be replaced with the contact\'\'s name when opening WhatsApp'**
  String get name_placeholder_info;

  /// No description provided for @cancel_button_text.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_button_text;

  /// No description provided for @empty_birthday_message_error.
  ///
  /// In en, this message translates to:
  /// **'A birthday greeting shouldn\'\'t be empty'**
  String get empty_birthday_message_error;

  /// No description provided for @too_short_birthday_error.
  ///
  /// In en, this message translates to:
  /// **'The message is too short'**
  String get too_short_birthday_error;

  /// No description provided for @save_birthday_button_text.
  ///
  /// In en, this message translates to:
  /// **'Save message'**
  String get save_birthday_button_text;

  /// No description provided for @edit_message_button_text.
  ///
  /// In en, this message translates to:
  /// **'Edit message'**
  String get edit_message_button_text;

  /// No description provided for @preview_whatsapp_text.
  ///
  /// In en, this message translates to:
  /// **'PREVIEW · WHATSAPP'**
  String get preview_whatsapp_text;

  /// No description provided for @home_tab_label.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_tab_label;

  /// No description provided for @settings_tab_label.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_tab_label;

  /// No description provided for @all_birthdays_tab_label.
  ///
  /// In en, this message translates to:
  /// **'Birthdays'**
  String get all_birthdays_tab_label;

  /// No description provided for @unknown_text.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown_text;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get change_language;

  /// No description provided for @spanish_language.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish_language;

  /// No description provided for @english_language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english_language;

  /// No description provided for @change_language_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get change_language_subtitle;

  /// No description provided for @change_language_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Select a language'**
  String get change_language_hint_text;

  /// No description provided for @os_language.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get os_language;

  /// No description provided for @getting_birthdays_error.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'\'t load the birthdays. Please try again.'**
  String get getting_birthdays_error;

  /// No description provided for @empty_birthdays_error.
  ///
  /// In en, this message translates to:
  /// **'You don\'\'t have any birthdays saved yet.'**
  String get empty_birthdays_error;

  /// No description provided for @save_birthday_reminder_button_text.
  ///
  /// In en, this message translates to:
  /// **'Save birthday'**
  String get save_birthday_reminder_button_text;

  /// No description provided for @no_contact_selected_error.
  ///
  /// In en, this message translates to:
  /// **'Please select a contact before saving.'**
  String get no_contact_selected_error;

  /// No description provided for @no_contact_phone_error.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'\'t get the phone number for this contact. Please try again.'**
  String get no_contact_phone_error;

  /// No description provided for @no_birthday_date_error.
  ///
  /// In en, this message translates to:
  /// **'Please select a birthday date.'**
  String get no_birthday_date_error;

  /// No description provided for @birthday_save_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while saving. Please try again.'**
  String get birthday_save_error;

  /// No description provided for @birthday_saved_with_reminder.
  ///
  /// In en, this message translates to:
  /// **'Birthday saved and reminder set! 🎂'**
  String get birthday_saved_with_reminder;

  /// No description provided for @birthday_saved_no_reminder.
  ///
  /// In en, this message translates to:
  /// **'Birthday saved successfully! 🎂'**
  String get birthday_saved_no_reminder;

  /// No description provided for @birthday_saved_reminder_failed.
  ///
  /// In en, this message translates to:
  /// **'Birthday saved, but we couldn\'\'t set the reminder. Check your notification permissions.'**
  String get birthday_saved_reminder_failed;

  /// No description provided for @birthday_deleted_success.
  ///
  /// In en, this message translates to:
  /// **'Reminder deleted successfully.'**
  String get birthday_deleted_success;

  /// No description provided for @birthday_deleted_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while deleting. Please try again.'**
  String get birthday_deleted_error;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
