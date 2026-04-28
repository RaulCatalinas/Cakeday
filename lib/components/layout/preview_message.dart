import 'package:cakeday/components/common/gradient_card.dart' show GradientCard;
import 'package:cakeday/components/common/input.dart' show Input;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/utils/toast.dart';
import 'package:flutter/material.dart'
    show
        Align,
        BuildContext,
        ButtonStyle,
        Color,
        Colors,
        Column,
        FontWeight,
        GestureDetector,
        Row,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextButton,
        TextEditingController,
        TextStyle,
        ValueListenableBuilder,
        Widget;
import 'package:flutter/services.dart' show HapticFeedback;

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
  bool messageInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!messageInitialized) {
      message = AppLocalizations.of(context)!.default_global_message;
      messageInitialized = true;
    }

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
              ),
              const SizedBox(height: 6),
              ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, _) {
                  final count = value.text.length;
                  final color = count < 10
                      ? const Color(0xFFFF3B30)
                      : const Color(0xFF6E6E73);

                  return Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.count_birthday_message_chars(count),
                        style: TextStyle(fontSize: 11, color: color),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '💡 {name} ${AppLocalizations.of(context)!.name_placeholder_info}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6E6E73),
                        ),
                      ),
                    ],
                  );
                },
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
                        color: Color(0xFF6E6E73),
                        fontWeight: .w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    style: const ButtonStyle(enableFeedback: true),
                    onPressed: () {
                      final value = controller.text.trim();

                      if (value.isEmpty) {
                        showToast(
                          type: .error,
                          msg: AppLocalizations.of(
                            context,
                          )!.empty_birthday_message_error,
                        );

                        return;
                      }

                      if (value.length < 10) {
                        showToast(
                          type: .error,
                          msg: AppLocalizations.of(
                            context,
                          )!.too_short_birthday_error,
                        );

                        return;
                      }

                      setState(() {
                        message = value;
                        editing = false;
                      });
                      widget.onChanged(value);
                      HapticFeedback.mediumImpact();
                    },
                    child: Text(
                      '💾 ${AppLocalizations.of(context)!.save_birthday_button_text}',
                      style: const TextStyle(
                        color: Color(0xFFFF6B6B),
                        fontWeight: FontWeight.w700,
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
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
