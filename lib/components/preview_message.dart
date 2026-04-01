import 'package:cakeday/components/input.dart' show Input;
import 'package:cakeday/utils/toast.dart';
import 'package:flutter/material.dart'
    show
        Align,
        Alignment,
        BoxDecoration,
        BuildContext,
        ButtonStyle,
        Color,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        FontWeight,
        GestureDetector,
        LinearGradient,
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
import 'package:flutter/services.dart';

class PreviewMessage extends StatefulWidget {
  final void Function(String) onChanged;

  const PreviewMessage({super.key, required this.onChanged});

  @override
  State<PreviewMessage> createState() => _PreviewMessageState();
}

class _PreviewMessageState extends State<PreviewMessage> {
  final controller = TextEditingController();
  bool editing = false;
  String message =
      "Happy birthday, {name}! 🎂🎉 Hope you're having an incredible day!";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PREVIEW · WHATSAPP',
          style: TextStyle(fontSize: 10, fontWeight: .w800, letterSpacing: 1),
        ),
        const SizedBox(height: 8),
        Container(
          padding: .all(12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
            ),
            borderRadius: .only(
              topLeft: .circular(14),
              topRight: .circular(14),
              bottomRight: .circular(4),
              bottomLeft: .circular(14),
            ),
          ),
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
                hintText: 'Birthday message',
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
                        '$count characters · minimum 10',
                        style: TextStyle(fontSize: 11, color: color),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '💡 {name} will be replaced with the contact\'s name when opening WhatsApp',
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
                    onPressed: () {
                      setState(() => editing = false);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
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
                          msg: "A birthday greeting shouldn't be empty",
                        );

                        return;
                      }

                      if (value.length < 10) {
                        showToast(
                          type: .error,
                          msg: 'The message is too short',
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
                    child: const Text(
                      '💾 Save message',
                      style: TextStyle(
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
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() => editing = true);
                HapticFeedback.lightImpact();
              },
              child: const Text(
                '✏️ Edit message',
                style: TextStyle(
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
