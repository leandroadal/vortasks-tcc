import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/shop/gems_controller.dart';
import 'package:vortasks/controllers/shop/product_controller.dart';
import 'package:vortasks/models/shop/gems_package.dart';
import 'package:vortasks/models/shop/product.dart';
part 'shop_store.g.dart';

class ShopStore = ShopStoreBase with _$ShopStore;

abstract class ShopStoreBase with Store {
  ShopStoreBase() {
    _loadProducts();
  }

  // ----------------- Products -----------------

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @observable
  ObservableList<Product> popularProducts = ObservableList<Product>();

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
  Future<void> _loadProducts({int page = 0}) async {
    productsError = null;
    productsLoading = true;
    try {
      final productsData = await ProductController().searchProducts(page: page);
      lastPageItemCount = productsData.length;
      if (page == 0) {
        products.clear(); // Limpa a lista apenas na primeira página
      }
      products.addAll(productsData);
    } catch (e) {
      productsError = e.toString();
    } finally {
      productsLoading = false;
    }
  }

  @action
  Future<void> reloadProducts({int page = 0}) async {
    await _loadProducts(page: page);
  }

  @action
  Future<void> mostPopularProducts() async {
    productsError = null;
    productsLoading = true;
    try {
      final productsData = await ProductController().searchProducts(
          direction: 'DESC', orderBy: 'totalSales', linesPerPage: 6);
      popularProducts.clear();
      popularProducts.addAll(productsData);
    } catch (e) {
      productsError = e.toString();
    } finally {
      productsLoading = false;
    }
  }

  // ----------------- Gems Packages -----------------

  @observable
  ObservableList<GemsPackage> gemsPackages = ObservableList<GemsPackage>();

  @observable
  String? gemsPackagesError;

  @observable
  bool gemsPackagesLoading = false;

  @observable
  int currentGemsIndex = 0;

  @action
  void setCurrentGemsIndex(int index) => currentGemsIndex = index;

  @action
  Future<void> loadGemsPackages() async {
    gemsPackagesError = null;
    gemsPackagesLoading = true;
    try {
      final gemsPackagesData = await GemsController().getGemsPackages();
      gemsPackages = ObservableList.of(gemsPackagesData);
    } catch (e) {
      gemsPackagesError = e.toString();
    } finally {
      gemsPackagesLoading = false;
    }
  }
}
