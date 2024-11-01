import 'package:flutter/material.dart';

class GroupActivitiesSection extends StatelessWidget {
  final VoidCallback onSeeMore;

  const GroupActivitiesSection({super.key, required this.onSeeMore});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Atividades em Grupo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(onPressed: onSeeMore, child: const Text('ver mais')),
      ],
    );
  }
}
