import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:flutter/material.dart'
    show AlertDialog, BuildContext, Navigator, Text, TextButton, showDialog;

Future<bool?> showConfirmDeleteBirthdayDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  return await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(AppLocalizations.of(context)!.cancel_text),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(AppLocalizations.of(context)!.delete_text),
        ),
      ],
    ),
  );
}
