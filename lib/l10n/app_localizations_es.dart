// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get add_birthday_header => 'Añadir cumpleaños';

  @override
  String get information_section_title => 'Información';

  @override
  String get select_contact => 'Selecciona de la lista de contactos';

  @override
  String get date_section_title => 'Fecha';

  @override
  String get year_of_birth => 'Año de nacimiento';

  @override
  String get message => 'Mensaje';

  @override
  String get personalized_message => 'Mensaje personalizado';

  @override
  String get personalized_message_input_hint_text =>
      'Mensaje de cumpleaños personalizado';

  @override
  String get note_section_title => 'Nota';

  @override
  String get note_input_hint_text => 'Por ejemplo: Le gusta el café';

  @override
  String get not_include_year_text => 'Opcional';
}
