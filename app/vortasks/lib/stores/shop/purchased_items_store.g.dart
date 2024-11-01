// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchased_items_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PurchasedItemsStore on PurchasedItemsStoreBase, Store {
  late final _$purchasedItemsAtom =
      Atom(name: 'PurchasedItemsStoreBase.purchasedItems', context: context);

  @override
  ObservableList<Product> get purchasedItems {
    _$purchasedItemsAtom.reportRead();
    return super.purchasedItems;
  }

  @override
  set purchasedItems(ObservableList<Product> value) {
    _$purchasedItemsAtom.reportWrite(value, super.purchasedItems, () {
      super.purchasedItems = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'PurchasedItemsStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'PurchasedItemsStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$PurchasedItemsStoreBaseActionController =
      ActionController(name: 'PurchasedItemsStoreBase', context: context);

  @override
  void setPurchasedItems(List<Product> items) {
    final _$actionInfo = _$PurchasedItemsStoreBaseActionController.startAction(
        name: 'PurchasedItemsStoreBase.setPurchasedItems');
    try {
      return super.setPurchasedItems(items);
    } finally {
      _$PurchasedItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPurchasedItem(Product item) {
    final _$actionInfo = _$PurchasedItemsStoreBaseActionController.startAction(
        name: 'PurchasedItemsStoreBase.addPurchasedItem');
    try {
      return super.addPurchasedItem(item);
    } finally {
      _$PurchasedItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePurchasedItem(int itemId) {
    final _$actionInfo = _$PurchasedItemsStoreBaseActionController.startAction(
        name: 'PurchasedItemsStoreBase.removePurchasedItem');
    try {
      return super.removePurchasedItem(itemId);
    } finally {
      _$PurchasedItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$PurchasedItemsStoreBaseActionController.startAction(
        name: 'PurchasedItemsStoreBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$PurchasedItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$PurchasedItemsStoreBaseActionController.startAction(
        name: 'PurchasedItemsStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$PurchasedItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadPurchasedItems() {
    final _$actionInfo = _$PurchasedItemsStoreBaseActionController.startAction(
        name: 'PurchasedItemsStoreBase.loadPurchasedItems');
    try {
      return super.loadPurchasedItems();
    } finally {
      _$PurchasedItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
purchasedItems: ${purchasedItems},
error: ${error},
isLoading: ${isLoading}
    ''';
  }
}
