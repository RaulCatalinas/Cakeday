import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/dialogs/confirm_delete_birthday.dart';
import 'package:cakeday/handlers/birthday/handle_delete_birthday.dart'
    show handleDeleteBirthday;
import 'package:cakeday/providers/birthdays_provider.dart'
    show birthdaysListProvider;
import 'package:cakeday/providers/selection_provider.dart'
    show selectionProvider;
import 'package:cakeday/screens/add_birthday.dart' show AddBirthdayScreen;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        ButtonStyle,
        Colors,
        Icon,
        IconButton,
        Icons,
        MaterialPageRoute,
        Navigator,
        PreferredSizeWidget,
        Row,
        Size,
        Widget,
        kToolbarHeight,
        SizedBox;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import 'package:logkeeper/logkeeper.dart';

class TaskBar extends ConsumerWidget implements PreferredSizeWidget {
  static const _buttonStyles = ButtonStyle(enableFeedback: true);

  const TaskBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionState = ref.watch(selectionProvider);
    final selectedIds = selectionState.selectedIds;

    return AppBar(
      actions: [
        Row(
          mainAxisAlignment: .end,
          children: [
            const SizedBox(width: 8),

            if (selectedIds.length == 1)
              IconButton(
                enableFeedback: true,
                iconSize: 21,
                onPressed: () async => await _editReminder(
                  context: context,
                  selectedIds: selectedIds,
                ),
                icon: const Icon(Icons.edit, color: Colors.blue),
                style: _buttonStyles,
              ),

            const SizedBox(width: 8),

            if (selectedIds.isNotEmpty)
              IconButton(
                enableFeedback: true,
                iconSize: 21,
                onPressed: () async => await _deleteReminder(
                  context: context,
                  selectedIds: selectedIds,
                  ref: ref,
                ),
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                style: _buttonStyles,
              ),
          ],
        ),
      ],
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
