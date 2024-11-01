import 'package:mobx/mobx.dart';
import 'package:vortasks/models/shop/gems_package.dart';
import 'package:vortasks/models/shop/cart_item.dart';

part 'cart_store.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  @observable
  ObservableList<CartItem> cartItems = ObservableList<CartItem>();

  @computed
  double get totalMoney {
    return cartItems.fold(
        0, (sum, item) => sum + (item.gemsPack.totalPrice * item.quantity));
  }

  @computed
  int get totalGems {
    return cartItems.fold(
        0, (sum, item) => sum + (item.gemsPack.gems * item.quantity));
  }

  @action
  void addToCart(GemsPackage gemsPack) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.gemsPack.id == gemsPack.id);

    if (existingItemIndex != -1) {
      // O produto já está no carrinho, aumenta a quantidade
      cartItems[existingItemIndex] = cartItems[existingItemIndex]
          .copyWith(quantity: cartItems[existingItemIndex].quantity + 1);
    } else {
      // O produto é novo no carrinho, adiciona com quantidade 1
      cartItems.add(CartItem(gemsPack: gemsPack, quantity: 1));
    }
  }

  @action
  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.gemsPack.id == productId);
  }

  @action
  void addToCartP(GemsPackage product) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.gemsPack.id == product.id);

    if (existingItemIndex != -1) {
      // O produto já está no carrinho, aumenta a quantidade
      cartItems[existingItemIndex] = cartItems[existingItemIndex]
          .copyWith(quantity: cartItems[existingItemIndex].quantity + 1);
    } else {
      // O produto é novo no carrinho, adiciona com quantidade 1
      cartItems.add(CartItem(gemsPack: product, quantity: 1));
    }
  }

  @action
  void removeFromCartP(int productId) {
    cartItems.removeWhere((item) => item.gemsPack.id == productId);
  }

  @action
  void clearCart() {
    cartItems.clear();
  }

  // Ação para atualizar a quantidade de um item no carrinho (opcional)
  @action
  void updateCartItemQuantity(int gemsPackId, int newQuantity) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.gemsPack.id == gemsPackId);

    if (existingItemIndex != -1) {
      cartItems[existingItemIndex] =
          cartItems[existingItemIndex].copyWith(quantity: newQuantity);
    }
  }

  @action
  void updateCartItemQuantityP(int productId, int newQuantity) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.gemsPack.id == productId);

    if (existingItemIndex != -1) {
      cartItems[existingItemIndex] =
          cartItems[existingItemIndex].copyWith(quantity: newQuantity);
    }
  }
}
