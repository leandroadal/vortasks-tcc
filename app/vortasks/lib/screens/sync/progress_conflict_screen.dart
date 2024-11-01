import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/user/progress_data.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';

class ProgressConflictScreen extends StatelessWidget {
  ProgressConflictScreen({super.key});

  final ProgressStore _progressStore = GetIt.I<ProgressStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conflito de Dados'),
      ),
      body: Observer(
        builder: (_) {
          if (_progressStore.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (_progressStore.hasConflict) {
            return _buildConflictResolution(context);
          } else {
            return const Center(child: Text('Sem conflitos.'));
          }
        },
      ),
    );
  }

  Widget _buildConflictResolution(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Detectamos um conflito em seus dados de progresso. Por favor, escolha qual versão você deseja manter:',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildProgressCard('Dados Locais', _progressStore.localProgress!),
            const SizedBox(height: 16),
            _buildProgressCard(
                'Dados do Servidor', _progressStore.remoteProgress!),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      _progressStore.setLoading(true);
                      await _progressStore.resolveConflictWithLocal();
                      _progressStore.setLoading(false);
                      _progressStore.setHasConflict(false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Dados locais mantidos.'),
                        ),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      _progressStore.setLoading(false);
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
                      _progressStore.setLoading(true);
                      await _progressStore.resolveConflictWithRemote();
                      _progressStore.setLoading(false);
                      _progressStore.setHasConflict(false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Dados do servidor mantidos.'),
                        ),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      _progressStore.setLoading(false);
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
                    child: Text('Manter Dados\ndo Servidor'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(String title, ProgressData progress) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              _buildProgressItem(
                  Icons.account_circle, 'Nível: ${progress.level}'),
              const SizedBox(height: 5),
              _buildProgressItem(Icons.star, 'XP: ${progress.xp}'),
              const SizedBox(height: 5),
              _buildProgressItem(Icons.money, 'Moedas: ${progress.coins}'),
              const SizedBox(height: 5),
              _buildProgressItem(Icons.diamond, 'Gemas: ${progress.gems}'),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
