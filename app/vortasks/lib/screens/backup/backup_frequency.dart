import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vortasks/stores/backup/backup_store.dart';

class BackupFrequency extends StatelessWidget {
  final BackupStore backupStore;
  const BackupFrequency({super.key, required this.backupStore});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequência de Backup',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        _buildFrequencyRadioButtons(),
      ],
    );
  }

  Widget _buildFrequencyRadioButtons() {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            RadioListTile(
              title: const Text('Manual'),
              value: null,
              groupValue: backupStore.selectedFrequency,
              onChanged: (value) {
                backupStore.selectedFrequency = value;
              },
            ),
            RadioListTile(
              title: const Text('Diário'),
              value: 'daily',
              groupValue: backupStore.selectedFrequency,
              onChanged: (value) {
                backupStore.selectedFrequency = value;
              },
            ),
            RadioListTile(
              title: const Text('Semanal'),
              value: 'weekly',
              groupValue: backupStore.selectedFrequency,
              onChanged: (value) {
                backupStore.selectedFrequency = value;
              },
            ),
          ],
        );
      },
    );
  }
}
