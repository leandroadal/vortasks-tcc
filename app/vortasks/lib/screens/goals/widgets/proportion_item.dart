import 'package:flutter/material.dart';

class ProportionItem extends StatelessWidget {
  final Color color;
  final String label;
  final int percentage;

  const ProportionItem({
    super.key,
    required this.color,
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          '$percentage%',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Text(label),
      ],
    );
  }
}
