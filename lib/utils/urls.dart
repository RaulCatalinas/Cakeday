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
    showToast(type: .error, msg: 'WhatsApp is not installed on this device');

    return;
  }

  await launchUrl(uri);
}
