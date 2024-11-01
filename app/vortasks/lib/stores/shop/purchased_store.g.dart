// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchased_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PurchasedStore on PurchasedStoreBase, Store {
  late final _$purchasedProductsAtom =
      Atom(name: 'PurchasedStoreBase.purchasedProducts', context: context);

  @override
  ObservableList<Product> get purchasedProducts {
    _$purchasedProductsAtom.reportRead();
    return super.purchasedProducts;
  }

  @override
  set purchasedProducts(ObservableList<Product> value) {
    _$purchasedProductsAtom.reportWrite(value, super.purchasedProducts, () {
      super.purchasedProducts = value;
    });
  }

  late final _$productsErrorAtom =
      Atom(name: 'PurchasedStoreBase.productsError', context: context);

  @override
  String? get productsError {
    _$productsErrorAtom.reportRead();
    return super.productsError;
  }

  @override
  set productsError(String? value) {
    _$productsErrorAtom.reportWrite(value, super.productsError, () {
      super.productsError = value;
    });
  }

  late final _$productsLoadingAtom =
      Atom(name: 'PurchasedStoreBase.productsLoading', context: context);

  @override
  bool get productsLoading {
    _$productsLoadingAtom.reportRead();
    return super.productsLoading;
  }

  @override
  set productsLoading(bool value) {
    _$productsLoadingAtom.reportWrite(value, super.productsLoading, () {
      super.productsLoading = value;
    });
  }

  late final _$currentProductIndexAtom =
      Atom(name: 'PurchasedStoreBase.currentProductIndex', context: context);

  @override
  int get currentProductIndex {
    _$currentProductIndexAtom.reportRead();
    return super.currentProductIndex;
  }

  @override
  set currentProductIndex(int value) {
    _$currentProductIndexAtom.reportWrite(value, super.currentProductIndex, () {
      super.currentProductIndex = value;
    });
  }

  late final _$mostPopularProductsAsyncAction =
      AsyncAction('PurchasedStoreBase.mostPopularProducts', context: context);

  @override
  Future<void> mostPopularProducts() {
    return _$mostPopularProductsAsyncAction
        .run(() => super.mostPopularProducts());
  }

  late final _$PurchasedStoreBaseActionController =
      ActionController(name: 'PurchasedStoreBase', context: context);

  @override
  void setCurrentProductIndex(int index) {
    final _$actionInfo = _$PurchasedStoreBaseActionController.startAction(
        name: 'PurchasedStoreBase.setCurrentProductIndex');
    try {
      return super.setCurrentProductIndex(index);
    } finally {
      _$PurchasedStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
purchasedProducts: ${purchasedProducts},
productsError: ${productsError},
productsLoading: ${productsLoading},
currentProductIndex: ${currentProductIndex}
    ''';
  }
}
