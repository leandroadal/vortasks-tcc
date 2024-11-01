import 'package:mobx/mobx.dart';
import 'package:vortasks/core/storage/local_storage.dart';
part 'sell_store.g.dart';

class SellStore = SellStoreBase with _$SellStore;

abstract class SellStoreBase with Store {
  SellStoreBase() {
    _loadCoins();
    _loadGems();
  }

  @observable
  int coins = 0;

  @action
  void setCoins(int coins) {
    this.coins = coins;
    _saveCoins();
  }

  @action
  void incrementCoins(int coins) {
    this.coins += coins;
    _saveCoins();
  }

  @action
  void decrementCoins(int coins) {
    final halfCoins = coins ~/ 2;
    this.coins -= halfCoins;
    _saveCoins();
  }

  @observable
  int gems = 0;

  @action
  void setGems(int gems) {
    this.gems = gems;
    _saveGems();
  }

  @action
  void incrementGems(int gems) {
    this.gems += gems;
    _saveGems();
  }

  @action
  void decrementGems(int gems) {
    this.gems -= gems;
    _saveGems();
  }

  @action
  void _loadCoins() {
    coins = LocalStorage.getInt('coins') ?? 0;
  }

  void _saveCoins() {
    LocalStorage.saveData('coins', coins);
  }

  @action
  void _loadGems() {
    gems = LocalStorage.getInt('gems') ?? 0;
  }

  void _saveGems() {
    LocalStorage.saveData('gems', gems);
  }
}
