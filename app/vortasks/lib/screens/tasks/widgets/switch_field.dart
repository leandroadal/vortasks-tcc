import 'package:flutter/material.dart';

class SwitchField extends StatelessWidget {
  final void Function(bool) onChanged;

  final bool value;

  final String title;

  const SwitchField(
      {super.key,
      required this.title,
      required this.onChanged,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10),
        Transform.scale(
          scale: 0.7,
          child: Switch(
            key: key,
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
