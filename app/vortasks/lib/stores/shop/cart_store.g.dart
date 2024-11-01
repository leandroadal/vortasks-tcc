// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on CartStoreBase, Store {
  Computed<double>? _$totalMoneyComputed;

  @override
  double get totalMoney =>
      (_$totalMoneyComputed ??= Computed<double>(() => super.totalMoney,
              name: 'CartStoreBase.totalMoney'))
          .value;
  Computed<int>? _$totalGemsComputed;

  @override
  int get totalGems => (_$totalGemsComputed ??=
          Computed<int>(() => super.totalGems, name: 'CartStoreBase.totalGems'))
      .value;

  late final _$cartItemsAtom =
      Atom(name: 'CartStoreBase.cartItems', context: context);

  @override
  ObservableList<CartItem> get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(ObservableList<CartItem> value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  late final _$CartStoreBaseActionController =
      ActionController(name: 'CartStoreBase', context: context);

  @override
  void addToCart(GemsPackage gemsPack) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.addToCart');
    try {
      return super.addToCart(gemsPack);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromCart(int productId) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.removeFromCart');
    try {
      return super.removeFromCart(productId);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToCartP(GemsPackage product) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.addToCartP');
    try {
      return super.addToCartP(product);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromCartP(int productId) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.removeFromCartP');
    try {
      return super.removeFromCartP(productId);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCart() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.clearCart');
    try {
      return super.clearCart();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCartItemQuantity(int gemsPackId, int newQuantity) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.updateCartItemQuantity');
    try {
      return super.updateCartItemQuantity(gemsPackId, newQuantity);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCartItemQuantityP(int productId, int newQuantity) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.updateCartItemQuantityP');
    try {
      return super.updateCartItemQuantityP(productId, newQuantity);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartItems: ${cartItems},
totalMoney: ${totalMoney},
totalGems: ${totalGems}
    ''';
  }
}
