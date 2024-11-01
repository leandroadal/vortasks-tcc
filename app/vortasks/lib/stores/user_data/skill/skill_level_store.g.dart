// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_level_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SkillLevelStore on SkillLevelStoreBase, Store {
  late final _$SkillLevelStoreBaseActionController =
      ActionController(name: 'SkillLevelStoreBase', context: context);

  @override
  void addSkillXP(String skillId, int gainedXP) {
    final _$actionInfo = _$SkillLevelStoreBaseActionController.startAction(
        name: 'SkillLevelStoreBase.addSkillXP');
    try {
      return super.addSkillXP(skillId, gainedXP);
    } finally {
      _$SkillLevelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void levelUpSkill(String skillId) {
    final _$actionInfo = _$SkillLevelStoreBaseActionController.startAction(
        name: 'SkillLevelStoreBase.levelUpSkill');
    try {
      return super.levelUpSkill(skillId);
    } finally {
      _$SkillLevelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
