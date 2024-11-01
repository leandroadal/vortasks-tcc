import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/stores/user_data/achievement/achievement_store.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidthSize = MediaQuery.of(context).size.width;
    final ProgressStore progressStore = GetIt.I<ProgressStore>();

    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: screenWidthSize > 600
            ? largeScreen(screenWidthSize, context, progressStore)
            : verticalScreen(context, progressStore),
      ),
    );
  }

  Row largeScreen(double screenWidthSize, BuildContext context,
      ProgressStore progressStore) {
    final AchievementStore achievementStore = GetIt.I<AchievementStore>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: [
                screenWidthSize > 800
                    ? const CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 40.0),
                      )
                    : Container(),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Observer(builder: (_) {
                      return Text(
                          'Nível: ${progressStore.levelStore.currentLevel}',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onSecondary));
                    }),
                    Observer(builder: (_) {
                      return Text('Moedas: ${progressStore.sellStore.coins}',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onSecondary));
                    }),
                    Observer(builder: (_) {
                      return Text('Gemas: ${progressStore.sellStore.gems}',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onSecondary));
                    }),
                    Observer(builder: (_) {
                      return screenWidthSize > 810
                          ? Text(
                              'Conquistas: ${achievementStore.unlockedAchievements.length}/${achievementStore.achievements.length}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary))
                          : Text(
                              'Conquistas:\n ${achievementStore.unlockedAchievements.length}/${achievementStore.achievements.length}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary));
                    }),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Observer(builder: (_) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: progressStore.levelStore.xpPercentage / 100,
                      color: Theme.of(context).colorScheme.secondary,
                      backgroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      strokeWidth: 8.0,
                    ),
                  ),
                  Text(
                    '${progressStore.levelStore.xpPercentage.toString().substring(0, 4)}%',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  Row verticalScreen(BuildContext context, ProgressStore progressStore) {
    final AchievementStore achievementStore = GetIt.I<AchievementStore>();

    return Row(
      children: [
        const CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 40.0),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(builder: (_) {
              return Text('Nível: ${progressStore.levelStore.currentLevel}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary));
            }),
            Observer(builder: (_) {
              return Text('Gemas: ${progressStore.sellStore.gems}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary));
            }),
            Observer(builder: (_) {
              return Text('Moedas: ${progressStore.sellStore.coins}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary));
            }),
            Observer(builder: (_) {
              return Text(
                  'Conquistas: ${achievementStore.unlockedAchievements.length}/${achievementStore.achievements.length}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary));
            }),
          ],
        ),
        const Spacer(),
        Observer(builder: (_) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: progressStore.levelStore.xpPercentage / 100,
                  color: Theme.of(context).colorScheme.onSecondary,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.2),
                  strokeWidth: 8.0,
                ),
              ),
              Text(
                '${progressStore.levelStore.xpPercentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
