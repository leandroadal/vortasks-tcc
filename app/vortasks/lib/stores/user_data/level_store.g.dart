// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LevelStore on LevelStoreBase, Store {
  Computed<int>? _$xpToNextLevelComputed;

  @override
  int get xpToNextLevel =>
      (_$xpToNextLevelComputed ??= Computed<int>(() => super.xpToNextLevel,
              name: 'LevelStoreBase.xpToNextLevel'))
          .value;
  Computed<double>? _$xpPercentageComputed;

  @override
  double get xpPercentage =>
      (_$xpPercentageComputed ??= Computed<double>(() => super.xpPercentage,
              name: 'LevelStoreBase.xpPercentage'))
          .value;

  late final _$currentLevelAtom =
      Atom(name: 'LevelStoreBase.currentLevel', context: context);

  @override
  int get currentLevel {
    _$currentLevelAtom.reportRead();
    return super.currentLevel;
  }

  @override
  set currentLevel(int value) {
    _$currentLevelAtom.reportWrite(value, super.currentLevel, () {
      super.currentLevel = value;
    });
  }

  late final _$xpAtom = Atom(name: 'LevelStoreBase.xp', context: context);

  @override
  int get xp {
    _$xpAtom.reportRead();
    return super.xp;
  }

  @override
  set xp(int value) {
    _$xpAtom.reportWrite(value, super.xp, () {
      super.xp = value;
    });
  }

  late final _$LevelStoreBaseActionController =
      ActionController(name: 'LevelStoreBase', context: context);

  @override
  void setCurrentLevel(int level) {
    final _$actionInfo = _$LevelStoreBaseActionController.startAction(
        name: 'LevelStoreBase.setCurrentLevel');
    try {
      return super.setCurrentLevel(level);
    } finally {
      _$LevelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setXP(int xp) {
    final _$actionInfo = _$LevelStoreBaseActionController.startAction(
        name: 'LevelStoreBase.setXP');
    try {
      return super.setXP(xp);
    } finally {
      _$LevelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addXP(int gainedXP) {
    final _$actionInfo = _$LevelStoreBaseActionController.startAction(
        name: 'LevelStoreBase.addXP');
    try {
      return super.addXP(gainedXP);
    } finally {
      _$LevelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void rmXP(int loseXP) {
    final _$actionInfo = _$LevelStoreBaseActionController.startAction(
        name: 'LevelStoreBase.rmXP');
    try {
      return super.rmXP(loseXP);
    } finally {
      _$LevelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void levelUp() {
    final _$actionInfo = _$LevelStoreBaseActionController.startAction(
        name: 'LevelStoreBase.levelUp');
    try {
      return super.levelUp();
    } finally {
      _$LevelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentLevel: ${currentLevel},
xp: ${xp},
xpToNextLevel: ${xpToNextLevel},
xpPercentage: ${xpPercentage}
    ''';
  }
}
