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
}
