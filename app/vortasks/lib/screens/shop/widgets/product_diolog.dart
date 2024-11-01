import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/controllers/shop/purchase_controller.dart';
import 'package:vortasks/core/data/Icon_manager.dart';
import 'package:vortasks/models/shop/product.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';
import 'package:vortasks/stores/shop/purchased_items_store.dart';
import 'package:vortasks/stores/shop/shop_store.dart';

class ProductDialog extends StatelessWidget {
  final List<Product> products;
  final int currentIndex;
  final Function(int) onChangeProduct;

  const ProductDialog({
    super.key,
    required this.products,
    required this.currentIndex,
    required this.onChangeProduct,
  });

  @override
  Widget build(BuildContext context) {
    final ShopStore shopStore = GetIt.I<ShopStore>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Observer(builder: (_) {
            final Product product = products[shopStore.currentProductIndex];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://drive.google.com/file/d/1dKonSbAhPPIbuZcrLz1bv4D2atLDqqU-/view?usp=sharing',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons
                        .error); // Exibe um ícone de erro se a imagem não carregar
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (product.coins > 0)
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/shop/money-icon.png',
                            height: 20,
                            width: 20,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '${product.coins}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    if (product.coins > 0 && product.gems > 0)
                      const SizedBox(width: 16),
                    if (product.gems > 0)
                      Row(
                        children: [
                          const Icon(
                            Icons.diamond,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '${product.gems}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: shopStore.currentProductIndex > 0
                          ? () => shopStore.setCurrentProductIndex(
                              shopStore.currentProductIndex - 1)
                          : null,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Ação de compra do produto
                        final progressStore = GetIt.I<ProgressStore>();
                        final purchasedItemsStore =
                            GetIt.I<PurchasedItemsStore>();

                        // Verifica se o usuário tem moedas/gemas suficientes
                        if (progressStore.sellStore.coins >= product.coins &&
                            progressStore.sellStore.gems >= product.gems) {
                          // Tenta realizar a compra
                          try {
                            // Inicia a compra na API
                            await PurchaseController()
                                .startProductPurchase(product.id);

                            // Se a compra for bem-sucedida:
                            // 1. Debita as moedas e gemas
                            progressStore.sellStore
                                .decrementCoins(product.coins);
                            progressStore.sellStore.decrementGems(product.gems);

                            // 2. Baixa o ícone do produto
                            if (product.icon.isNotEmpty) {
                              await IconManager()
                                  .downloadAndSaveIcon(product.icon);
                            }

                            purchasedItemsStore.addPurchasedItem(product);

                            // 3. Fecha o diálogo
                            Navigator.pop(context);

                            // 4. Exibe um SnackBar de sucesso
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Compra realizada com sucesso!')),
                            );
                          } catch (e) {
                            // Em caso de erro, exibe um SnackBar de erro
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Erro ao realizar a compra: $e')),
                            );
                          }
                        } else {
                          // Exibe um SnackBar informando que o usuário não tem moedas/gemas suficientes
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Moedas ou gemas insuficientes!')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Comprar'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed:
                          shopStore.currentProductIndex < products.length - 1
                              ? () => shopStore.setCurrentProductIndex(
                                  shopStore.currentProductIndex + 1)
                              : null,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            );
          }),
        ),
      ),
    );
  }
}
