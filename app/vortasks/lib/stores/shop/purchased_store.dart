import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/shop/product_controller.dart';
import 'package:vortasks/models/shop/product.dart';

part 'purchased_store.g.dart';

class PurchasedStore = PurchasedStoreBase with _$PurchasedStore;

abstract class PurchasedStoreBase with Store {
  PurchasedStoreBase() {}

  @observable
  ObservableList<Product> purchasedProducts = ObservableList<Product>();

  @observable
  String? productsError;

  @observable
  bool productsLoading = false;

  @observable
  int currentProductIndex = 0;

  int lastPageItemCount = 0;

  @action
  void setCurrentProductIndex(int index) => currentProductIndex = index;

  @action
  Future<void> mostPopularProducts() async {
    productsError = null;
    productsLoading = true;
    try {
      await ProductController().searchProducts(
          direction: 'DESC', orderBy: 'totalSales', linesPerPage: 6);
    } catch (e) {
      productsError = e.toString();
    } finally {
      productsLoading = false;
    }
  }
}
