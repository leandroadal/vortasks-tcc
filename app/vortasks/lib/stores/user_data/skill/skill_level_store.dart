import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/models/skill/skill.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';

part 'skill_level_store.g.dart';

class SkillLevelStore = SkillLevelStoreBase with _$SkillLevelStore;

abstract class SkillLevelStoreBase with Store {
  final SkillStore _skillStore = GetIt.I<SkillStore>();

  // Getter para o XP necessário para o próximo nível da habilidade
  int getXPToNextLevel(String skillId) {
    final skill = _skillStore.skills.firstWhere((s) => s.id == skillId);
    int currentLevel = skill.level ?? 1;
    return 500 + (currentLevel * 500);
  }

  // Getter para a porcentagem de XP da habilidade
  double getXPPercentage(String skillId) {
    final skill = _skillStore.skills.firstWhere((s) => s.id == skillId);
    int currentXP = skill.xp?.toInt() ?? 0;
    int xpToNextLevel = getXPToNextLevel(skillId);
    return (currentXP / xpToNextLevel) * 100;
  }

  // Adiciona XP à habilidade e sobe de nível se necessário
  @action
  void addSkillXP(String skillId, int gainedXP) {
    final skillIndex = _skillStore.skills.indexWhere((s) => s.id == skillId);
    if (skillIndex != -1) {
      final skill = _skillStore.skills[skillIndex];
      int currentXP = skill.xp?.toInt() ?? 0;
      int newXP = currentXP + gainedXP;

      // Cria uma nova instância de Skill com o XP atualizado
      final updatedSkill = Skill(
        id: skill.id,
        name: skill.name,
        xp: newXP.toDouble(),
        level: skill.level,
        taskThemes: skill.taskThemes,
      );
      _skillStore.updateSkill(updatedSkill);

      if (newXP >= getXPToNextLevel(skillId)) {
        levelUpSkill(skillId);
      }
    }
  }

  // Sobe o nível da habilidade
  @action
  void levelUpSkill(String skillId) {
    final skillIndex = _skillStore.skills.indexWhere((s) => s.id == skillId);
    if (skillIndex != -1) {
      final skill = _skillStore.skills[skillIndex];
      int currentLevel = skill.level ?? 1;

      // Cria uma nova instância de Skill com o nível e XP atualizados
      final updatedSkill = Skill(
        id: skill.id,
        name: skill.name,
        xp: 0,
        level: currentLevel + 1,
        taskThemes: skill.taskThemes,
      );
      _skillStore.updateSkill(updatedSkill);
    }
  }
}
