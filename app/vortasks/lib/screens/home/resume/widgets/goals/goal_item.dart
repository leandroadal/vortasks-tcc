import 'package:flutter/material.dart';

class GoalItem extends StatelessWidget {
  final String label;
  final double progress;
  final Color color;
  final int goal;

  const GoalItem(this.label, this.progress, this.color,
      {super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4.0),
        LinearProgressIndicator(
          value: progress,
          color: color,
          backgroundColor: const Color.fromARGB(169, 224, 224, 224),
          minHeight: 8.0,
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${(progress * 100).toStringAsFixed(1)} %'),
            Text('${(progress * goal).toStringAsFixed(0)} / $goal'),
          ],
        ),
      ],
    );
  }
}
