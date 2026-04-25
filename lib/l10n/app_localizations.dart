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

  /// No description provided for @not_include_year_text.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get not_include_year_text;

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
  /// **'We couldn\'t load your birthdays. Please try again in a moment.'**
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
