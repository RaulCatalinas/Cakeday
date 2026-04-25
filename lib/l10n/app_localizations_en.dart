// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get add_birthday => 'Add birthday';

  @override
  String get information => 'Information';

  @override
  String get select_contact => 'Select from the contacts list';

  @override
  String get date => 'Date';

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
  String get note => 'Note';

  @override
  String get note_input_hint_text => 'E.g.: He likes coffee';
}
