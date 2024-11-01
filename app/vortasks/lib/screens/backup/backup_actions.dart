import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/stores/backup/backup_store.dart';

class BackupActions extends StatelessWidget {
  const BackupActions({super.key});

  @override
  Widget build(BuildContext context) {
    final BackupStore backupStore = GetIt.I<BackupStore>();
    return Center(
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 16),
                      Text("Enviando dados para o servidor..."),
                    ],
                  ),
                ),
              );
              await backupStore.create(); // Envia para o servidor
              if (backupStore.error == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Backup enviado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Erro ao enviar backup',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                backupStore.setError(null);
              }
            },
            child: const Text('Criar Backup'),
          ),
          ElevatedButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 16),
                      Text("Enviando dados para o servidor..."),
                    ],
                  ),
                ),
              );

              await backupStore.sync(); // Envia para o servidor
              if (backupStore.error == null) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Backup enviado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      backupStore.error!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                backupStore.setError(null);
              }
            },
            child: const Text('Enviar Backup'),
          ),
        ],
      ),
    );
  }
}
