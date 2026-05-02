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
  String get optional_text => 'Opcional';

  @override
  String get all_birthdays_header => 'Todos los cumpleaños';

  @override
  String get app_search_bar_hint_text => 'Buscar recordatorios';

  @override
  String get could_not_load_birthdays_error =>
      'No hemos podido cargar tus cumpleaños. Inténtalo de nuevo dentro de un momento.';

  @override
  String get not_birthdays_yet_information =>
      'Aún no hay cumpleaños.\nAñade alguno desde la pantalla de añadir.';

  @override
  String get no_search_matches_error =>
      'No se han encontrado resultados que coincidan con tu búsqueda.\nPrueba con otro nombre o fecha.';

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
  String get edit_message_button_text => 'Editar mensaje';

  @override
  String get preview_whatsapp_text => 'VISTA PREVIA · WHATSAPP';

  @override
  String get home_tab_label => 'Inicio';

  @override
  String get settings_tab_label => 'Configuración';

  @override
  String get all_birthdays_tab_label => 'Cumpleaños';

  @override
  String get unknown_text => 'Desconocido';

  @override
  String get change_language => 'Idioma de la aplicación';

  @override
  String get spanish_language => 'Español';

  @override
  String get english_language => 'Ingles';

  @override
  String get change_language_subtitle => 'Elige tu idioma preferido';

  @override
  String get change_language_hint_text => 'Selecciona un idioma';

  @override
  String get os_language => 'Predeterminado del sistema';

  @override
  String get getting_birthdays_error =>
      'No se han podido cargar los cumpleaños. Inténtalo de nuevo.';

  @override
  String get empty_birthdays_error => 'Aún no tienes cumpleaños guardados.';

  @override
  String get save_birthday_reminder_button_text => 'Guardar cumpleaños';

  @override
  String get no_contact_selected_error =>
      'Por favor, selecciona un contacto antes de guardar.';

  @override
  String get no_contact_phone_error =>
      'No hemos podido obtener el número de teléfono de este contacto. Inténtalo de nuevo.';

  @override
  String get no_birthday_date_error =>
      'Por favor, selecciona una fecha de cumpleaños.';

  @override
  String get birthday_save_error =>
      'Algo ha ido mal al guardar. Inténtalo de nuevo.';

  @override
  String get reminder_configured_successfully => '¡Recordatorio programado! 🎂';

  @override
  String get birthday_saved => '¡Cumpleaños guardado correctamente! 🎂';

  @override
  String get reminder_configuration_failed =>
      'No hemos podido programar el recordatorio. Revisa los permisos de notificación.';

  @override
  String get birthday_deleted_success =>
      'Recordatorio eliminado correctamente.';

  @override
  String get birthday_deleted_error =>
      'Algo ha ido mal al eliminar. Inténtalo de nuevo.';

  @override
  String get notification_could_not_be_scheduled =>
      'No se ha podido programar la notificación';

  @override
  String get retry_text => 'Reintentar';

  @override
  String get delete_text => 'Eliminar';

  @override
  String get confirm_delete_birthday_dialog_content =>
      '¿Seguro que quieres borrar este recordatorio?';

  @override
  String get cancel_text => 'Cancelar';

  @override
  String get today_text => 'Hoy';

  @override
  String get tomorrow_text => 'Mañana';

  @override
  String turns_age(int age) {
    return 'Cumple $age';
  }

  @override
  String days_remaining(int days) {
    return 'En $days dias';
  }

  @override
  String weeks_remaining(int weeks) {
    return 'En $weeks semanas';
  }

  @override
  String months_remaining(int months) {
    return 'En $months meses';
  }

  @override
  String years_remaining(int years) {
    return 'En $years años';
  }

  @override
  String years_and_months_remaining(int years, int months) {
    return 'En $years años and $months meses';
  }

  @override
  String get no_birthdays_today => 'Hoy no hay cumpleaños 🎂';

  @override
  String get no_upcoming_birthdays =>
      'No hay cumpleaños en los próximos 30 días.';

  @override
  String get birthday_already_exists =>
      'Ya tienes un recordatorio para esta persona.';
}
