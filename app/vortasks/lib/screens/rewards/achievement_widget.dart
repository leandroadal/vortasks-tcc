import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/achievement/achievement.dart';
import 'package:vortasks/stores/user_data/achievement/achievement_store.dart';

class AchievementWidget extends StatelessWidget {
  const AchievementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AchievementStore achievementStore = GetIt.I<AchievementStore>();

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Conquistas',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Observer(
              builder: (_) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    // Calcula a largura disponível para os itens do Wrap
                    double availableWidth = constraints.maxWidth;
                    // Calcula a largura de cada item, garantindo 2 colunas
                    double itemWidth = (availableWidth - 16.0) /
                        2; // 16.0 é o espaçamento entre as colunas

                    return Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      alignment: WrapAlignment.center,
                      children:
                          achievementStore.achievements.map((achievement) {
                        return SizedBox(
                          width: itemWidth,
                          height: itemWidth,
                          child: _buildAchievementItem(achievement, context),
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementItem(Achievement achievement, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              achievement.unlocked ? Icons.emoji_events : Icons.lock,
              color: achievement.unlocked ? Colors.amber : Colors.grey,
              size: 32.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              achievement.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration:
                    achievement.unlocked ? null : TextDecoration.lineThrough,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                achievement.description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
