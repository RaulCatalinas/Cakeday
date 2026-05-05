import 'package:cakeday/managers/language_manager.dart' show LanguageManager;
import 'package:cakeday/utils/toast.dart' show showToast;
import 'package:url_launcher/url_launcher.dart' show launchUrl, canLaunchUrl;

Future<void> openWhatsApp({
  required String phone,
  required String message,
  required String name,
}) async {
  final cleanPhone = phone.trim().replaceAll(RegExp(r'[\s\-\(\)]'), '');
  final finalMessage = message.trim().replaceAll('{name}', name);
  final encodedMessage = Uri.encodeComponent(finalMessage);

  final uri = Uri.parse(
    'whatsapp://send?phone=$cleanPhone&text=$encodedMessage',
  );

  if (!await canLaunchUrl(uri)) {
    final languageCode = LanguageManager.getLanguageCode();
    final isSpanish = languageCode == 'es';

    showToast(
      type: .error,
      msg: isSpanish
          ? 'No hemos podido abrir WhatsApp para enviar el mensaje de cumpleaños.'
          : 'We couldn\'t open WhatsApp to send the birthday message.',
    );

    return;
  }

  await launchUrl(uri);
}
