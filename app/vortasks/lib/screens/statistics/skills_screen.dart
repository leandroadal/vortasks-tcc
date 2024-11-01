import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/skill/skill.dart';
import 'package:vortasks/screens/widgets/my_app_bar.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:vortasks/stores/user_data/skill/skill_level_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SkillStore skillStore = GetIt.I<SkillStore>();

    return Scaffold(
      appBar: const MyAppBar(title: 'Habilidades'),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Observer(
          builder: (_) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 80.0), // Espaçamento superior e inferior
              itemCount: skillStore.skills.length,
              itemBuilder: (context, index) {
                final Skill skill = skillStore.skills[index];
                return _buildSkillItem(skill, context);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  Widget _buildSkillItem(Skill skill, BuildContext context) {
    final SkillLevelStore skillLevelStore = GetIt.I<SkillLevelStore>();

    return SizedBox(
      height: 85,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: Theme.of(context).colorScheme.inversePrimary.withAlpha(250),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          title: Text(
            skill.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          trailing: SizedBox(
            width: 50,
            height: 80,
            child: Observer(builder: (_) {
              final xpPercentage = skillLevelStore.getXPPercentage(skill.id);

              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      value: xpPercentage / 100,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onSecondaryContainer),
                      strokeWidth: 8.0,
                    ),
                  ),
                  Text(
                    '${skill.level ?? 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
