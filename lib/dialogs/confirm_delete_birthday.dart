import 'package:cakeday/l10n/app_localizations.dart';
import 'package:flutter/material.dart'
    show AlertDialog, BuildContext, Navigator, Text, TextButton, showDialog;

Future<bool> showConfirmDeleteBirthdayDialog({
  required BuildContext context,
}) async {
  return await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.delete_text),
      content: Text(
        AppLocalizations.of(context)!.confirm_delete_birthday_dialog_content,
      ),
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
