import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/dialogs/confirm_delete_birthday.dart'
    show showConfirmDeleteBirthdayDialog;
import 'package:cakeday/handlers/birthday/handle_delete_birthday.dart'
    show handleDeleteBirthday;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/providers/birthdays_provider.dart'
    show birthdaysListProvider;
import 'package:cakeday/providers/selection_provider.dart'
    show selectionProvider;
import 'package:cakeday/screens/add_birthday.dart' show AddBirthdayScreen;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        Container,
        Icon,
        Icons,
        MaterialPageRoute,
        Navigator,
        Row,
        Text,
        TextButton,
        TextStyle,
        Theme,
        Widget,
        ButtonStyle;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import 'package:logkeeper/logkeeper.dart' show LogKeeper;

class SelectionActionBar extends ConsumerWidget {
  static const ButtonStyle _buttonStyles = ButtonStyle(enableFeedback: true);

  const SelectionActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIds = ref.watch(selectionProvider).selectedIds;

    return Container(
      padding: const .symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(
        context,
      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
      child: Row(
        mainAxisAlignment: .spaceEvenly,
        children: [
          if (selectedIds.length == 1)
            TextButton.icon(
              style: _buttonStyles,
              onPressed: () async => await _editReminder(
                context: context,
                selectedIds: selectedIds,
              ),
              icon: const Icon(Icons.edit),
              label: Text(
                AppLocalizations.of(context)!.edit_reminder_button_text,
              ),
            ),

          TextButton.icon(
            style: _buttonStyles,
            onPressed: () async => await _deleteReminder(
              context: context,
              selectedIds: selectedIds,
              ref: ref,
            ),
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            label: Text(
              AppLocalizations.of(context)!.delete_reminder_button_text,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteReminder({
    required BuildContext context,
    required Set<int> selectedIds,
    required WidgetRef ref,
  }) async {
    try {
      final deleteReminder = await showConfirmDeleteBirthdayDialog(
        context: context,
        title: AppLocalizations.of(context)!.delete_text,
        content: AppLocalizations.of(
          context,
        )!.confirm_delete_birthday_dialog_content,
      );

      if (deleteReminder == null || !deleteReminder) return;

      final selectionNotifier = ref.read(selectionProvider.notifier);

      for (var id in selectedIds) {
        await handleDeleteBirthday(id: id, context: context);
      }

      selectionNotifier.clearSelection();
      ref.invalidate(birthdaysListProvider);
    } catch (e, stackTrace) {
      LogKeeper.error('Error trying to delete the selected reminder(s): $e');
      LogKeeper.error('StackTrace: $stackTrace');
    }
  }

  Future<void> _editReminder({
    required BuildContext context,
    required Set<int> selectedIds,
  }) async {
    try {
      final birthday = await DbManager.getBirthdayById(selectedIds.first);

      if (birthday == null) return;

      final birthdayData = BirthdayData.fromBirthday(birthday);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddBirthdayScreen(birthdayToEdit: birthdayData),
        ),
      );
    } catch (e, stackTrace) {
      LogKeeper.error('Error trying to edit the selected reminder:: $e');
      LogKeeper.error('StackTrace: $stackTrace');
    }
  }
}
