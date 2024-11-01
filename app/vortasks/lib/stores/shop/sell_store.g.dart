// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SellStore on SellStoreBase, Store {
  late final _$coinsAtom = Atom(name: 'SellStoreBase.coins', context: context);

  @override
  int get coins {
    _$coinsAtom.reportRead();
    return super.coins;
  }

  @override
  set coins(int value) {
    _$coinsAtom.reportWrite(value, super.coins, () {
      super.coins = value;
    });
  }

  late final _$gemsAtom = Atom(name: 'SellStoreBase.gems', context: context);

  @override
  int get gems {
    _$gemsAtom.reportRead();
    return super.gems;
  }

  @override
  set gems(int value) {
    _$gemsAtom.reportWrite(value, super.gems, () {
      super.gems = value;
    });
  }

  late final _$SellStoreBaseActionController =
      ActionController(name: 'SellStoreBase', context: context);

  @override
  void setCoins(int coins) {
    final _$actionInfo = _$SellStoreBaseActionController.startAction(
        name: 'SellStoreBase.setCoins');
    try {
      return super.setCoins(coins);
    } finally {
      _$SellStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementCoins(int coins) {
    final _$actionInfo = _$SellStoreBaseActionController.startAction(
        name: 'SellStoreBase.incrementCoins');
    try {
      return super.incrementCoins(coins);
    } finally {
      _$SellStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementCoins(int coins) {
    final _$actionInfo = _$SellStoreBaseActionController.startAction(
        name: 'SellStoreBase.decrementCoins');
    try {
      return super.decrementCoins(coins);
    } finally {
      _$SellStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGems(int gems) {
    final _$actionInfo = _$SellStoreBaseActionController.startAction(
        name: 'SellStoreBase.setGems');
    try {
      return super.setGems(gems);
    } finally {
      _$SellStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementGems(int gems) {
    final _$actionInfo = _$SellStoreBaseActionController.startAction(
        name: 'SellStoreBase.incrementGems');
    try {
      return super.incrementGems(gems);
    } finally {
      _$SellStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementGems(int gems) {
    final _$actionInfo = _$SellStoreBaseActionController.startAction(
        name: 'SellStoreBase.decrementGems');
    try {
      return super.decrementGems(gems);
    } finally {
      _$SellStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _loadCoins() {
    final _$actionInfo = _$SellStoreBaseActionController.startAction(
        name: 'SellStoreBase._loadCoins');
    try {
      return super._loadCoins();
    } finally {
      _$SellStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _loadGems() {
    final _$actionInfo = _$SellStoreBaseActionController.startAction(
        name: 'SellStoreBase._loadGems');
    try {
      return super._loadGems();
    } finally {
      _$SellStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
coins: ${coins},
gems: ${gems}
    ''';
  }
}
