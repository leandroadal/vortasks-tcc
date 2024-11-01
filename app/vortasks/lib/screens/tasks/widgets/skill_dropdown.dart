import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/stores/tasks/task_form_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';

class SkillDropdown extends StatelessWidget {
  final TaskFormStore addTaskStore;

  const SkillDropdown({super.key, required this.addTaskStore});

  @override
  Widget build(BuildContext context) {
    final SkillStore skillStore = GetIt.I<SkillStore>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habilidades Relacionadas:',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Observer(builder: (_) {
          final filteredSkills = skillStore.skills
              .where((skill) =>
                  skill.taskThemes.contains(addTaskStore.selectedTaskTheme))
              .toList();

          return Wrap(
            spacing: 8.0,
            children: filteredSkills.map((skill) {
              return FilterChip(
                label: Text(
                  skill.name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                selectedColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
                selected: addTaskStore.selectedSkills.contains(skill.id),
                onSelected: (bool selected) {
                  if (selected) {
                    addTaskStore.addSelectedSkill(skill.id);
                  } else {
                    addTaskStore.removeSelectedSkill(skill.id);
                  }
                },
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
