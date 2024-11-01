import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/backup/backup.dart';
import 'package:vortasks/screens/backup/backup_data_card.dart';
import 'package:vortasks/stores/backup/backup_store.dart';

class BackupConflictScreen extends StatelessWidget {
  BackupConflictScreen({super.key});

  final BackupStore _backupStore = GetIt.I<BackupStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restauração de Dados'),
        ),
        body: _buildConflictResolution(context));
  }

  Widget _buildConflictResolution(BuildContext context) {
    final backupLocal = _backupStore.backup;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            backupLocal != null
                ? const Text(
                    'Detectamos versões diferentes de seus dados de backup. Por favor, escolha qual versão você deseja manter:',
                    textAlign: TextAlign.center,
                  )
                : const Text(
                    'Deseja restaurar dados que estão no servidor? ',
                    textAlign: TextAlign.center,
                  ),
            const SizedBox(height: 32),
            backupLocal != null
                ? _buildBackupCard('Dados Locais', backupLocal)
                : Container(),
            const SizedBox(height: 16),
            _buildBackupCard('Dados do Servidor', _backupStore.remoteBackup!),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _backupStore.resolveConflictWithLocal();
                      _backupStore.setHasConflict(false);
                      const SnackBar(
                        content: Text('Dados locais mantidos.'),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Erro ao resolver conflito. Tente novamente mais tarde.'),
                        ),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text('Manter Dados\nLocais'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _backupStore.resolveConflictWithRemote();
                      _backupStore.setHasConflict(false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Dados do servidor mantidos.'),
                        ),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Erro ao resolver conflito. Tente novamente mais tarde.'),
                        ),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text('Restaurar Dados\ndo Servidor'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupCard(String title, Backup backup) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          BackupDataCard(backup: backup),
        ],
      ),
    );
  }
}
