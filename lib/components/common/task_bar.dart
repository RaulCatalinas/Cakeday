import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/dialogs/confirm_delete_birthday.dart';
import 'package:cakeday/handlers/birthday/handle_delete_birthday.dart'
    show handleDeleteBirthday;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/providers/birthdays_provider.dart'
    show birthdaysListProvider;
import 'package:cakeday/providers/selection_provider.dart'
    show SelectionNotifier, selectionProvider;
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Colors,
        PreferredSizeWidget,
        Row,
        Size,
        SizedBox,
        Text,
        TextButton,
        TextStyle,
        Theme,
        Widget,
        kToolbarHeight;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget, WidgetRef;

class TaskBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const TaskBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskBarState();
}

class _TaskBarState extends ConsumerState<TaskBar> {
  static final _buttonStyles = TextButton.styleFrom(
    enableFeedback: true,
    foregroundColor: Colors.red,
    disabledForegroundColor: Colors.red.withValues(alpha: 0.38),
  );

  @override
  Widget build(BuildContext context) {
    final selectionState = ref.watch(selectionProvider);
    final selectionNotifier = ref.read(selectionProvider.notifier);
    final allBirthdays = ref.watch(birthdaysListProvider).value ?? [];

    final hasNoBirthdays = allBirthdays.isEmpty;
    final selectedIds = selectionState.selectedIds;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      title: Text(
        selectedIds.length == 1
            ? AppLocalizations.of(context)!.one_birthday_selected
            : AppLocalizations.of(
                context,
              )!.multiple_birthdays_selected(selectedIds.length),
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      actions: [
        Row(
          mainAxisAlignment: .end,
          children: [
            const SizedBox(width: 8),

            TextButton(
              onPressed: hasNoBirthdays
                  ? null
                  : () async => await _deleteAllReminders(
                      context: context,
                      selectionNotifier: selectionNotifier,
                      ref: ref,
                    ),
              style: _buttonStyles,
              child: Text(
                AppLocalizations.of(context)!.delete_all_reminders_button_text,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _deleteAllReminders({
    required BuildContext context,
    required SelectionNotifier selectionNotifier,
    required WidgetRef ref,
  }) async {
    final deleteReminder = await showConfirmDeleteBirthdayDialog(
      context: context,
      title: AppLocalizations.of(context)!.delete_all_reminders_button_text,
      content: AppLocalizations.of(
        context,
      )!.delete_all_reminders_dialog_content,
    );

    if (deleteReminder == null || !deleteReminder) return;

    final birthdays = await DbManager.getAllBirthdays();

    for (var birthday in birthdays) {
      await handleDeleteBirthday(id: birthday.id, context: context);
    }

    selectionNotifier.clearSelection();
    ref.invalidate(birthdaysListProvider);
  }
}
