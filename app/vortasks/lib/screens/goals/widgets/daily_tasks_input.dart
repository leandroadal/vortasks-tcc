import 'package:flutter/material.dart';
import 'package:vortasks/screens/goals/widgets/total_tasks_info_dialog.dart';

class DailyTasksInput extends StatelessWidget {
  final TextEditingController totalDailyTasksController;
  final Function(String) onChanged;

  const DailyTasksInput({
    super.key,
    required this.totalDailyTasksController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quantas tarefas você deseja realizar por dia?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: totalDailyTasksController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Total',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um número';
                      }
                      return null;
                    },
                    onChanged: onChanged,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const TotalTasksInfoDialog(),
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
