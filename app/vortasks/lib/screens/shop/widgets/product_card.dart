import 'package:flutter/material.dart';
import 'package:vortasks/screens/shop/widgets/product_diolog.dart';
import 'package:vortasks/stores/shop/shop_store.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required ShopStore shopStore,
    required this.productIndex,
    this.popular = false,
  }) : _shopStore = shopStore;

  final ShopStore _shopStore;
  final int productIndex;
  final bool popular;

  @override
  Widget build(BuildContext context) {
    // Acessa a lista com base no valor de `popular`
    final product = popular
        ? _shopStore.popularProducts[productIndex]
        : _shopStore.products[productIndex];

    return Card(
      child: InkWell(
        onTap: () {
          _shopStore.setCurrentProductIndex(productIndex);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Exibe o diálogo com os detalhes do produto
              if (popular) {
                return ProductDialog(
                  products: _shopStore.popularProducts,
                  currentIndex: productIndex,
                  onChangeProduct: (newIndex) {
                    _shopStore.setCurrentProductIndex(newIndex);
                  },
                );
              } else {
                return ProductDialog(
                  products: _shopStore.products,
                  currentIndex: productIndex,
                  onChangeProduct: (newIndex) {
                    _shopStore.setCurrentProductIndex(newIndex);
                  },
                );
              }
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                product.icon,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image);
                },
                height: 40,
                width: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 2.0),
              Text(
                '${product.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/shop/money-icon.png',
                        height: 20,
                        width: 20,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 2.0),
                      Text(
                        '${product.coins}',
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.diamond,
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                      const SizedBox(width: 2.0),
                      Text(
                        '${product.gems}',
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
