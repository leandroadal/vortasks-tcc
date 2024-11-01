import 'package:mobx/mobx.dart';
import 'package:vortasks/core/storage/local_storage.dart';

part 'level_store.g.dart';

class LevelStore = LevelStoreBase with _$LevelStore;

abstract class LevelStoreBase with Store {
  LevelStoreBase() {
    _loadLevelData();
  }

  @observable
  int currentLevel = 1;

  @action
  void setCurrentLevel(int level) {
    currentLevel = level;
    _saveCurrentLevel();
  }

  @observable
  int xp = 0;

  @action
  void setXP(int xp) {
    this.xp = xp;
    _saveXp();
  }

  @computed
  int get xpToNextLevel => 300 + (currentLevel * 100);

  @computed
  double get xpPercentage => (xp / xpToNextLevel) * 100;

  @action
  void addXP(int gainedXP) {
    xp += gainedXP;
    if (xp >= xpToNextLevel) {
      levelUp();
    }
    _saveLevelData();
  }

  @action
  void rmXP(int loseXP) {
    xp -= loseXP;
    if (xp >= xpToNextLevel) {
      levelUp();
    }
    _saveLevelData();
  }

  @action
  void levelUp() {
    currentLevel++;
    xp = 0;
    _saveLevelData();
  }

  // ================ Armazenamento local ================

  // Carregar dados de nível do armazenamento local
  void _loadLevelData() {
    currentLevel = LocalStorage.getString('currentLevel') != null
        ? int.parse(LocalStorage.getString('currentLevel')!)
        : 1;
    xp = LocalStorage.getString('xp') != null
        ? int.parse(LocalStorage.getString('xp')!)
        : 0;
  }

  // Salvar dados de nível no armazenamento local
  void _saveLevelData() {
    _saveCurrentLevel();
    _saveXp();
    _saveXpToNextLevel();
  }

  void _saveCurrentLevel() {
    LocalStorage.saveData('currentLevel', currentLevel.toString());
  }

  void _saveXp() {
    LocalStorage.saveData('xp', xp.toString());
  }

  void _saveXpToNextLevel() {
    LocalStorage.saveData('xpToNextLevel', xpToNextLevel.toString());
  }
}
