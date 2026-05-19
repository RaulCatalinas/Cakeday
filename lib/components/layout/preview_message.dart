import 'package:cakeday/components/common/character_counter.dart'
    show CharacterCounter;
import 'package:cakeday/components/common/gradient_card.dart' show GradientCard;
import 'package:cakeday/components/common/input.dart' show Input;
import 'package:cakeday/components/common/subtitle.dart';
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/preferences.dart' show Preferences;
import 'package:flutter/material.dart'
    show
        Align,
        BuildContext,
        ButtonStyle,
        Color,
        Colors,
        Column,
        GestureDetector,
        Row,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextButton,
        TextEditingController,
        TextStyle,
        Widget,
        WidgetsBinding;
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:logkeeper/logkeeper.dart';

class PreviewMessage extends StatefulWidget {
  final void Function(String) onChanged;

  const PreviewMessage({super.key, required this.onChanged});

  @override
  State<PreviewMessage> createState() => _PreviewMessageState();
}

class _PreviewMessageState extends State<PreviewMessage> {
  final controller = TextEditingController();

  bool editing = false;
  String message = '';
  bool canSave = false;
  int charCount = 0;
  bool messageInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!messageInitialized) {
      final globalMessage = Preferences.getGlobalMessage();

      if (globalMessage != null) {
        setState(() {
          message = globalMessage;
        });

        LogKeeper.info('Global message loaded from preferences successfully.');

        messageInitialized = true;
      } else {
        setState(() {
          message = AppLocalizations.of(context)!.default_global_message;
        });

        Preferences.saveGlobalMessage(message)
            .then((_) => LogKeeper.info('Default global message saved.'))
            .catchError(
              (e, stackTrace) => {
                LogKeeper.error('Error saving default message: $e'),
                LogKeeper.error('StackTrace: $stackTrace'),
              },
            );
      }

      messageInitialized = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.onChanged(message);
    });

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          AppLocalizations.of(context)!.preview_whatsapp_text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: .w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        GradientCard(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
        const SizedBox(height: 10),
        if (editing)
          Column(
            children: [
              Input(
                controller: controller,
                hintText: AppLocalizations.of(
                  context,
                )!.global_birthday_input_hint_text,
                maxLines: 3,
                onChanged: (value) => setState(() => charCount = value.length),
              ),
              const SizedBox(height: 6),
              Column(
                crossAxisAlignment: .start,
                children: [
                  CharacterCounter(
                    count: charCount,
                    minimum: 10,
                    label: AppLocalizations.of(
                      context,
                    )!.count_birthday_message_chars(controller.text.length),
                    onMinimumReached: () => setState(() => canSave = true),
                    onTooShort: () => setState(() => canSave = false),
                  ),
                  const SizedBox(height: 4),
                  Subtitle(
                    text:
                        '💡 {name} ${AppLocalizations.of(context)!.name_placeholder_info}',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: .end,
                children: [
                  TextButton(
                    style: const ButtonStyle(enableFeedback: true),
                    onPressed: () => setState(() => editing = false),
                    child: Text(
                      AppLocalizations.of(context)!.cancel_button_text,
                      style: const TextStyle(
                        color: Color(0xFFFF6B6B),
                        fontWeight: .w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    style: const ButtonStyle(enableFeedback: true),
                    onPressed: canSave ? _saveMessage : null,
                    child: Text(
                      '💾 ${AppLocalizations.of(context)!.save_birthday_button_text}',
                      style: TextStyle(
                        color: canSave ? Color(0xFFFF6B6B) : Color(0xFF6E6E73),
                        fontWeight: .w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        else
          Align(
            alignment: .centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() => editing = true);
                HapticFeedback.lightImpact();
              },
              child: Text(
                '✏️ ${AppLocalizations.of(context)!.edit_message_button_text}',
                style: const TextStyle(
                  color: Color(0xFFFF6B6B),
                  fontWeight: .w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _saveMessage() {
    final value = controller.text.trim();

    setState(() {
      message = value;
      editing = false;
    });
    widget.onChanged(value);
    HapticFeedback.mediumImpact();
  }
}
