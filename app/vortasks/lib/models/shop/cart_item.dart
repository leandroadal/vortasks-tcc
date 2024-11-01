import 'package:vortasks/models/shop/gems_package.dart';

class CartItem {
  final GemsPackage gemsPack;
  int quantity;

  CartItem({required this.gemsPack, required this.quantity});

  CartItem copyWith({
    GemsPackage? product,
    int? quantity,
  }) {
    return CartItem(
      gemsPack: product ?? this.gemsPack,
      quantity: quantity ?? this.quantity,
    );
  }
}
