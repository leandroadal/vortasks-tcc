// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShopStore on ShopStoreBase, Store {
  late final _$productsAtom =
      Atom(name: 'ShopStoreBase.products', context: context);

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$popularProductsAtom =
      Atom(name: 'ShopStoreBase.popularProducts', context: context);

  @override
  ObservableList<Product> get popularProducts {
    _$popularProductsAtom.reportRead();
    return super.popularProducts;
  }

  @override
  set popularProducts(ObservableList<Product> value) {
    _$popularProductsAtom.reportWrite(value, super.popularProducts, () {
      super.popularProducts = value;
    });
  }

  late final _$productsErrorAtom =
      Atom(name: 'ShopStoreBase.productsError', context: context);

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
      Atom(name: 'ShopStoreBase.productsLoading', context: context);

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
      Atom(name: 'ShopStoreBase.currentProductIndex', context: context);

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

  late final _$gemsPackagesAtom =
      Atom(name: 'ShopStoreBase.gemsPackages', context: context);

  @override
  ObservableList<GemsPackage> get gemsPackages {
    _$gemsPackagesAtom.reportRead();
    return super.gemsPackages;
  }

  @override
  set gemsPackages(ObservableList<GemsPackage> value) {
    _$gemsPackagesAtom.reportWrite(value, super.gemsPackages, () {
      super.gemsPackages = value;
    });
  }

  late final _$gemsPackagesErrorAtom =
      Atom(name: 'ShopStoreBase.gemsPackagesError', context: context);

  @override
  String? get gemsPackagesError {
    _$gemsPackagesErrorAtom.reportRead();
    return super.gemsPackagesError;
  }

  @override
  set gemsPackagesError(String? value) {
    _$gemsPackagesErrorAtom.reportWrite(value, super.gemsPackagesError, () {
      super.gemsPackagesError = value;
    });
  }

  late final _$gemsPackagesLoadingAtom =
      Atom(name: 'ShopStoreBase.gemsPackagesLoading', context: context);

  @override
  bool get gemsPackagesLoading {
    _$gemsPackagesLoadingAtom.reportRead();
    return super.gemsPackagesLoading;
  }

  @override
  set gemsPackagesLoading(bool value) {
    _$gemsPackagesLoadingAtom.reportWrite(value, super.gemsPackagesLoading, () {
      super.gemsPackagesLoading = value;
    });
  }

  late final _$currentGemsIndexAtom =
      Atom(name: 'ShopStoreBase.currentGemsIndex', context: context);

  @override
  int get currentGemsIndex {
    _$currentGemsIndexAtom.reportRead();
    return super.currentGemsIndex;
  }

  @override
  set currentGemsIndex(int value) {
    _$currentGemsIndexAtom.reportWrite(value, super.currentGemsIndex, () {
      super.currentGemsIndex = value;
    });
  }

  late final _$_loadProductsAsyncAction =
      AsyncAction('ShopStoreBase._loadProducts', context: context);

  @override
  Future<void> _loadProducts({int page = 0}) {
    return _$_loadProductsAsyncAction
        .run(() => super._loadProducts(page: page));
  }

  late final _$reloadProductsAsyncAction =
      AsyncAction('ShopStoreBase.reloadProducts', context: context);

  @override
  Future<void> reloadProducts({int page = 0}) {
    return _$reloadProductsAsyncAction
        .run(() => super.reloadProducts(page: page));
  }

  late final _$mostPopularProductsAsyncAction =
      AsyncAction('ShopStoreBase.mostPopularProducts', context: context);

  @override
  Future<void> mostPopularProducts() {
    return _$mostPopularProductsAsyncAction
        .run(() => super.mostPopularProducts());
  }

  late final _$loadGemsPackagesAsyncAction =
      AsyncAction('ShopStoreBase.loadGemsPackages', context: context);

  @override
  Future<void> loadGemsPackages() {
    return _$loadGemsPackagesAsyncAction.run(() => super.loadGemsPackages());
  }

  late final _$ShopStoreBaseActionController =
      ActionController(name: 'ShopStoreBase', context: context);

  @override
  void setCurrentProductIndex(int index) {
    final _$actionInfo = _$ShopStoreBaseActionController.startAction(
        name: 'ShopStoreBase.setCurrentProductIndex');
    try {
      return super.setCurrentProductIndex(index);
    } finally {
      _$ShopStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentGemsIndex(int index) {
    final _$actionInfo = _$ShopStoreBaseActionController.startAction(
        name: 'ShopStoreBase.setCurrentGemsIndex');
    try {
      return super.setCurrentGemsIndex(index);
    } finally {
      _$ShopStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
popularProducts: ${popularProducts},
productsError: ${productsError},
productsLoading: ${productsLoading},
currentProductIndex: ${currentProductIndex},
gemsPackages: ${gemsPackages},
gemsPackagesError: ${gemsPackagesError},
gemsPackagesLoading: ${gemsPackagesLoading},
currentGemsIndex: ${currentGemsIndex}
    ''';
  }
}
