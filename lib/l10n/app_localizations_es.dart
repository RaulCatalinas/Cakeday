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

  @override
  String get all_birthdays_header => 'Todos los cumpleaños';

  @override
  String get app_search_bar_hint_text => 'Buscar recordatorios';

  @override
  String get could_not_load_birthdays_error =>
      'No hemos podido cargar tus cumpleaños. Inténtalo de nuevo dentro de un momento.';

  @override
  String get not_birthdays_yet_information =>
      'No birthdays yet.\nAdd someone using the add screen.';

  @override
  String get no_search_matches_error =>
      'No reminders match your search.\nTry another name or date.';

  @override
  String get general_message_section_title => 'Mensaje general';

  @override
  String get notifications_section_title => 'Notificaciones';

  @override
  String get enable_notifications => 'Activar notificaciones';

  @override
  String get enable_notifications_subtitle => 'Te avisa el día del cumpleaños';

  @override
  String get notification_time => 'Hora de notificación';

  @override
  String get notification_time_subtitle => 'Se repite cada año';

  @override
  String get advance_notice => 'Aviso previo';

  @override
  String get advance_notice_subtitle => 'Avisa también el día anterior';

  @override
  String get appearance_section_title => 'Apariencia';

  @override
  String get dark_mode => 'Modo oscuro';

  @override
  String get dark_mode_subtitle => 'Cambiar entre el tema claro y el oscuro';

  @override
  String get global_birthday_input_hint_text => 'Mensaje de cumpleaños';

  @override
  String get default_global_message =>
      '¡Feliz cumpleaños, {name}! 🎂🎉 ¡Espero que estés pasando un día increíble!';

  @override
  String count_birthday_message_chars(int count) {
    return '$count caracteres · mínimo 10';
  }

  @override
  String get name_placeholder_info =>
      'se sustituirá por el nombre del contacto al abrir WhatsApp';

  @override
  String get cancel_button_text => 'Cancelar';

  @override
  String get empty_birthday_message_error =>
      'El mensaje de cumpleaños no debe estar vacio';

  @override
  String get too_short_birthday_error => 'El mensaje es demasiado corto';

  @override
  String get save_birthday_button_text => 'Guardar mensaje';

  @override
  String get edit_message_button_text => 'Edit message';

  @override
  String get preview_whatsapp_text => 'VISTA PREVIA · WHATSAPP';
}
