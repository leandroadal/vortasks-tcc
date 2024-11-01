import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/backup/backup_actions.dart';
import 'package:vortasks/screens/backup/backup_data_card.dart';
import 'package:vortasks/screens/backup/backup_frequency.dart';
import 'package:vortasks/stores/backup/backup_store.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BackupStore backupStore = GetIt.I<BackupStore>();
    final backup = backupStore.backup;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dados do último Backup',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            backup != null
                ? BackupDataCard(backup: backup)
                : const Text('Nenhum backup foi feito'),
            const SizedBox(height: 32.0),
            BackupFrequency(backupStore: backupStore),
            const SizedBox(height: 32.0),
            const BackupActions(),
          ],
        ),
      ),
    );
  }
}
