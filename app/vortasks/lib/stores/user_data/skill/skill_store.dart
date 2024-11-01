import 'package:mobx/mobx.dart';

import 'package:vortasks/core/storage/local_storage.dart';
import 'dart:convert';

import 'package:vortasks/models/skill/skill.dart';

part 'skill_store.g.dart';

class SkillStore = SkillStoreBase with _$SkillStore;

abstract class SkillStoreBase with Store {
  SkillStoreBase() {
    skills = ObservableList.of(defaultSkills);
    _loadSkills();
  }

  @observable
  ObservableList<Skill> skills = ObservableList<Skill>();

  @action
  void setSkills(List<Skill> skills) {
    this.skills.clear();
    this.skills.addAll(skills);
    _saveSkills();
  }

  @action
  void updateSkill(Skill skill) {
    final index = skills.indexWhere((s) => s.id == skill.id);
    if (index != -1) {
      skills[index] = skill;
      _saveSkills();
    }
  }

  @action
  void deleteSkill(String skillId) {
    skills.removeWhere((skill) => skill.id == skillId);
    _saveSkills();
  }

  // ================ Armazenamento local ================

  // Carregar skills do armazenamento local
  void _loadSkills() {
    final skillsJson = LocalStorage.getString('skills');
    if (skillsJson != null) {
      skills = ObservableList.of(
          (json.decode(skillsJson) as List).map((e) => Skill.fromJson(e)));
    }
  }

  // Salvar skills no armazenamento local
  void _saveSkills() {
    LocalStorage.saveData('skills', json.encode(skills));
  }
}
