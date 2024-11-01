import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/shop/product_controller.dart';
import 'package:vortasks/core/storage/local_storage.dart';
import 'package:vortasks/models/shop/product.dart';
import 'package:vortasks/stores/user_store.dart';
part 'purchased_items_store.g.dart';

class PurchasedItemsStore = PurchasedItemsStoreBase with _$PurchasedItemsStore;

abstract class PurchasedItemsStoreBase with Store {
  PurchasedItemsStoreBase() {
    loadPurchasedItems();
  }

  @observable
  ObservableList<Product> purchasedItems = ObservableList<Product>();

  @observable
  String? error;

  @observable
  bool isLoading = false;

  @action
  void setPurchasedItems(List<Product> items) {
    purchasedItems.clear();
    purchasedItems.addAll(items);
    _savePurchasedItems();
  }

  @action
  void addPurchasedItem(Product item) {
    purchasedItems.add(item);
    _savePurchasedItems();
  }

  @action
  void removePurchasedItem(int itemId) {
    purchasedItems.removeWhere((item) => item.id == itemId);
    _savePurchasedItems();
  }

  @action
  void setError(String? value) => error = value;

  @action
  void setLoading(bool value) => isLoading = value;

  // Salva os produtos comprados no armazenamento local
  void _savePurchasedItems() {
    final itemsJson = jsonEncode(purchasedItems);
    LocalStorage.saveData('purchasedProducts', itemsJson);
  }

  // Carrega os produtos comprados do armazenamento local
  @action
  void loadPurchasedItems() {
    setLoading(true);
    final itemsJson = LocalStorage.getString('purchasedProducts');
    if (itemsJson != null) {
      try {
        final List<dynamic> decodedJson = jsonDecode(itemsJson);
        final List<Product> loadedItems =
            decodedJson.map((item) => Product.fromJson(item)).toList();
        purchasedItems = ObservableList.of(loadedItems);
      } catch (e) {
        setError('Erro ao carregar dados do armazenamento local');
      }
    }
    setLoading(false);
  }

  Future<void> loadPurchasedProducts() async {
    // Se o usuário estiver logado, carrega os produtos da API e salva localmente
    if (GetIt.I<UserStore>().isLoggedIn) {
      try {
        final products = await ProductController().getPurchasedProducts();
        setPurchasedItems(products);
      } catch (e) {
        print('Erro ao carregar produtos comprados: ${e.toString()}');
      }
    } else {
      loadPurchasedItems();
    }
  }
}
