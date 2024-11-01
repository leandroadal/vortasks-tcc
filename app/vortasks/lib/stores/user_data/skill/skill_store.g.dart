// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SkillStore on SkillStoreBase, Store {
  late final _$skillsAtom =
      Atom(name: 'SkillStoreBase.skills', context: context);

  @override
  ObservableList<Skill> get skills {
    _$skillsAtom.reportRead();
    return super.skills;
  }

  @override
  set skills(ObservableList<Skill> value) {
    _$skillsAtom.reportWrite(value, super.skills, () {
      super.skills = value;
    });
  }

  late final _$SkillStoreBaseActionController =
      ActionController(name: 'SkillStoreBase', context: context);

  @override
  void setSkills(List<Skill> skills) {
    final _$actionInfo = _$SkillStoreBaseActionController.startAction(
        name: 'SkillStoreBase.setSkills');
    try {
      return super.setSkills(skills);
    } finally {
      _$SkillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSkill(Skill skill) {
    final _$actionInfo = _$SkillStoreBaseActionController.startAction(
        name: 'SkillStoreBase.updateSkill');
    try {
      return super.updateSkill(skill);
    } finally {
      _$SkillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteSkill(String skillId) {
    final _$actionInfo = _$SkillStoreBaseActionController.startAction(
        name: 'SkillStoreBase.deleteSkill');
    try {
      return super.deleteSkill(skillId);
    } finally {
      _$SkillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
skills: ${skills}
    ''';
  }
}
