import 'package:cakeday/components/birthday/days_remaining.dart'
    show DaysRemaining;
import 'package:cakeday/components/birthday/schedule_birthday_notification.dart'
    show ScheduleBirthdayNotification;
import 'package:cakeday/components/common/app_card.dart' show AppCard;
import 'package:cakeday/components/common/gradient_card.dart' show GradientCard;
import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/providers/selection_provider.dart'
    show selectionProvider;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:cakeday/utils/strings.dart' show StringNormalization;
import 'package:flutter/material.dart'
    show
        BuildContext,
        CircleAvatar,
        Colors,
        Column,
        Expanded,
        InkWell,
        Localizations,
        Material,
        MemoryImage,
        Row,
        SizedBox,
        Text,
        TextStyle,
        Theme,
        VoidCallback,
        Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget, WidgetRef;
import 'package:intl/intl.dart' show DateFormat;
import 'package:logkeeper/logkeeper.dart';

class ReminderCard extends ConsumerStatefulWidget {
  final ContactInfo? contactInfo;
  final bool notificationScheduled;
  final bool useGradientCard;
  final int? id;
  final VoidCallback? onRetryNotification;
  final String? note;
  final bool? showOutline;

  const ReminderCard({
    super.key,
    required this.contactInfo,
    this.id,
    this.notificationScheduled = false,
    this.useGradientCard = false,
    this.onRetryNotification,
    this.note,
    this.showOutline,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReminderCardState();
}

class _ReminderCardState extends ConsumerState<ReminderCard> {
  var isSelected = false;

  @override
  Widget build(BuildContext context) {
    return widget.useGradientCard
        ? GradientCard(child: _getCommonChild(context, ref))
        : AppCard(
            padding: 15.0,
            isSelected: widget.showOutline ?? isSelected,
            child: _getCommonChild(context, ref),
          );
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      try {
        final selectionState = ref.read(selectionProvider);
        final id = await _getReminderId();
        final selected = selectionState.selectedIds.contains(id);

        setState(() => isSelected = selected);
      } catch (e, stackTrace) {
        LogKeeper.error('Error retrieving the reminder ID: $e');
        LogKeeper.error('StackTrace: $stackTrace');
      }
    });
  }

  Widget _getCommonChild(BuildContext context, WidgetRef ref) {
    final (rawName, _, photo, birthday) =
        widget.contactInfo?.asRecord ??
        (
          AppLocalizations.of(context)!.unknown_text,
          AppLocalizations.of(context)!.unknown_text,
          null,
          null,
        );

    final name = rawName.safeForDisplay;
    final note = widget.note?.safeForDisplay;

    final locale = Localizations.localeOf(context).toString();
    final formattedMonthAndDay = birthday != null
        ? DateFormat.MMMd(locale).format(birthday)
        : AppLocalizations.of(context)!.unknown_text;

    final content = InkWell(
      enableFeedback: true,
      onLongPress: () async => await _onLongPress(ref: ref),
      onTap: () async => await _onTap(context: context, ref: ref),
      child: Column(
        mainAxisAlignment: .start,
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              CircleAvatar(
                radius: 24,
                foregroundImage: photo != null ? MemoryImage(photo) : null,
                child: photo == null
                    ? Text(
                        name.isNotEmpty
                            ? name.firstLetter.toUpperCase()
                            : AppLocalizations.of(
                                context,
                              )!.unknown_text[0].toUpperCase(),
                      )
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: TextStyle(fontSize: 19, fontWeight: .w600),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  Text(
                    formattedMonthAndDay,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                  if (birthday != null)
                    DaysRemaining(
                      birthday: birthday,
                      todayColor: widget.useGradientCard
                          ? Colors.green.shade900
                          : null,
                    ),
                ],
              ),
              if (note != null)
                Text(
                  note,
                  maxLines: 2,
                  overflow: .ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (!widget.notificationScheduled)
            ScheduleBirthdayNotification(
              onRetryNotification: widget.onRetryNotification,
            ),
        ],
      ),
    );

    if (!widget.useGradientCard) return content;

    return Material(color: Colors.transparent, child: content);
  }

  Future<int> _getReminderId() async {
    var id = widget.id;

    if (id == null) {
      final dbId = await DbManager.getIdByInfo(
        name: widget.contactInfo!.name,
        phone: widget.contactInfo!.phone ?? '',
        date: widget.contactInfo!.birthday ?? DateTime(0),
      );

      id = dbId!;
    }

    return id;
  }

  Future<void> _onLongPress({required WidgetRef ref}) async {
    final selectionState = ref.read(selectionProvider);

    if (selectionState.multiSelectMode) return;

    final selectionNotifier = ref.read(selectionProvider.notifier);

    setState(() => isSelected = !isSelected);

    final id = await _getReminderId();

    selectionNotifier.enterMultiSelect(id);
  }

  Future<void> _onTap({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final selectionState = ref.read(selectionProvider);

    if (!selectionState.multiSelectMode) return;

    final selectionNotifier = ref.read(selectionProvider.notifier);

    setState(() => isSelected = !isSelected);

    final id = await _getReminderId();

    selectionNotifier.toggleSelection(id);
  }
}
