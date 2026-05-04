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
  String get information_section_title => 'Contacto';

  @override
  String get select_contact => 'Elige de tus contactos';

  @override
  String get date_section_title => 'Cumpleaños';

  @override
  String get year_of_birth => 'Año de nacimiento';

  @override
  String get message => 'Mensaje';

  @override
  String get personalized_message => 'Mensaje personalizado';

  @override
  String get personalized_message_input_hint_text =>
      'Escribe un mensaje de cumpleaños personal…';

  @override
  String get note_section_title => 'Nota';

  @override
  String get note_input_hint_text =>
      'Por ejemplo: Le encanta la tarta de chocolate';

  @override
  String get optional_text => 'Opcional';

  @override
  String get all_birthdays_header => 'Todos los cumpleaños';

  @override
  String get app_search_bar_hint_text => 'Busca por nombre o fecha…';

  @override
  String get could_not_load_birthdays_error =>
      'No hemos podido cargar tus cumpleaños. Desliza hacia abajo para volver a intentarlo.';

  @override
  String get not_birthdays_yet_information =>
      'Aún no tienes cumpleaños.\n¡Pulsa el botón + para añadir el primero!';

  @override
  String get no_search_matches_error =>
      'No se han encontrado resultados.\nPrueba con otro nombre o mes.';

  @override
  String get general_message_section_title => 'Mensaje de cumpleaños';

  @override
  String get notifications_section_title => 'Recordatorios';

  @override
  String get enable_notifications => 'Activar recordatorios';

  @override
  String get enable_notifications_subtitle =>
      'Recibe un aviso el día del cumpleaños';

  @override
  String get notification_time => 'Hora del recordatorio';

  @override
  String get notification_time_subtitle =>
      'Recibirás el aviso a esta hora cada año';

  @override
  String get advance_notice => 'Aviso anticipado';

  @override
  String get advance_notice_subtitle => 'Avísame también el día anterior';

  @override
  String get appearance_section_title => 'Apariencia';

  @override
  String get dark_mode => 'Modo oscuro';

  @override
  String get dark_mode_subtitle => 'Cambia entre el tema claro y el oscuro';

  @override
  String get global_birthday_input_hint_text =>
      'Escribe tu mensaje de cumpleaños predeterminado…';

  @override
  String get default_global_message =>
      '¡Feliz cumpleaños, {name}! 🎂🎉 ¡Espero que estés pasando un día increíble!';

  @override
  String count_birthday_message_chars(int count) {
    return '$count caracteres · mínimo 10';
  }

  @override
  String get name_placeholder_info =>
      'se sustituirá por el nombre de tu contacto al abrir WhatsApp';

  @override
  String get cancel_button_text => 'Cancelar';

  @override
  String get empty_birthday_message_error =>
      'Escribe un mensaje de cumpleaños antes de guardar.';

  @override
  String get too_short_birthday_error =>
      'El mensaje es demasiado corto. Escribe al menos 10 caracteres.';

  @override
  String get save_birthday_button_text => 'Guardar mensaje';

  @override
  String get edit_message_button_text => 'Editar mensaje';

  @override
  String get preview_whatsapp_text => 'VISTA PREVIA · WHATSAPP';

  @override
  String get home_tab_label => 'Inicio';

  @override
  String get settings_tab_label => 'Ajustes';

  @override
  String get all_birthdays_tab_label => 'Cumpleaños';

  @override
  String get unknown_text => 'Desconocido';

  @override
  String get change_language => 'Idioma de la app';

  @override
  String get spanish_language => 'Español';

  @override
  String get english_language => 'Inglés';

  @override
  String get change_language_subtitle => 'Elige el idioma que prefieras';

  @override
  String get change_language_hint_text => 'Selecciona un idioma';

  @override
  String get os_language => 'Usar el idioma del dispositivo';

  @override
  String get getting_birthdays_error =>
      'No hemos podido cargar los cumpleaños. Inténtalo de nuevo.';

  @override
  String get empty_birthdays_error =>
      'Aún no tienes cumpleaños guardados.\n¡Pulsa + para empezar!';

  @override
  String get save_birthday_reminder_button_text => 'Guardar cumpleaños';

  @override
  String get no_contact_selected_error => 'Elige un contacto primero.';

  @override
  String get no_contact_phone_error =>
      'No hemos encontrado un número de teléfono para este contacto. Prueba con otro.';

  @override
  String get no_birthday_date_error => 'Selecciona la fecha de cumpleaños.';

  @override
  String get birthday_save_error => 'Algo ha ido mal. Inténtalo de nuevo.';

  @override
  String get reminder_configured_successfully =>
      '¡Recordatorio programado! Te avisaremos el gran día 🎂';

  @override
  String get birthday_saved => '¡Cumpleaños guardado! 🎂';

  @override
  String get reminder_configuration_failed =>
      'Cumpleaños guardado, pero no hemos podido programar el recordatorio. Ve a Ajustes para activar las notificaciones.';

  @override
  String get birthday_deleted_success => 'Recordatorio eliminado.';

  @override
  String get birthday_deleted_error =>
      'No hemos podido eliminar el recordatorio. Inténtalo de nuevo.';

  @override
  String get notification_could_not_be_scheduled =>
      'No hemos podido programar el recordatorio para este cumpleaños.';

  @override
  String get retry_text => 'Reintentar';

  @override
  String get delete_text => 'Eliminar';

  @override
  String get confirm_delete_birthday_dialog_content =>
      '¿Seguro que quieres eliminar este recordatorio? Esta acción no se puede deshacer.';

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
    return 'En $days días';
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
    return 'En $years años y $months meses';
  }

  @override
  String get no_birthdays_today => 'Hoy no hay cumpleaños 🎂';

  @override
  String get no_upcoming_birthdays =>
      'No hay cumpleaños en los próximos 30 días.';

  @override
  String get birthday_already_exists =>
      'Ya tienes un recordatorio para esta persona.';

  @override
  String get today_birthdays_section_title => 'Hoy';

  @override
  String get upcoming_birthdays_section_title => 'Próximamente';

  @override
  String get update_birthday_error =>
      'No hemos podido guardar los cambios. Inténtalo de nuevo.';

  @override
  String get update_birthday_success => '¡Cumpleaños actualizado! 🎂';

  @override
  String get reminder_updated_successfully => '¡Recordatorio actualizado! 🎂';

  @override
  String get reminder_update_failed =>
      'No hemos podido actualizar el recordatorio. Ve a Ajustes para comprobar los permisos de notificación.';

  @override
  String get birthday_reminder_title => '🎂 ¡Cumpleaños hoy!';

  @override
  String birthday_reminder_body(String name) {
    return '¡Hoy es el cumpleaños de $name! Pulsa para enviar tus felicitaciones 🎉';
  }

  @override
  String get contacts_permission_denied =>
      'Para añadir cumpleaños más rápido, permite a Cakeday acceder a tus contactos en Ajustes.';

  @override
  String get contacts_permission_permanently_denied =>
      'El acceso a los contactos está bloqueado. Puedes activarlo en los Ajustes de tu teléfono.';

  @override
  String get contacts_permission_limited =>
      'Solo has compartido algunos contactos. Es posible que algunas personas no aparezcan en la lista.';

  @override
  String get contacts_permission_restricted =>
      'Tu dispositivo no permite el acceso a los contactos. Revisa el control parental o los ajustes del dispositivo.';

  @override
  String get notifications_permission_denied =>
      'Activa las notificaciones para que Cakeday pueda recordarte los cumpleaños.';

  @override
  String get notifications_permission_permanently_denied =>
      'Las notificaciones están desactivadas. Puedes activarlas en los Ajustes de tu teléfono.';

  @override
  String get notifications_permission_restricted =>
      'Tu dispositivo no permite las notificaciones. Revisa el control parental o los ajustes del dispositivo.';
}
