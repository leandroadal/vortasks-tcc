import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:vortasks/stores/shop/cart_store.dart';
import 'package:vortasks/screens/shop/payment_data_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = GetIt.I<CartStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Observer(
              builder: (_) {
                if (cartStore.cartItems.isEmpty) {
                  return _buildEmptyCartMessage(context);
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: _buildCartItemsList(context, cartStore),
                      ),
                      _buildCartSummary(context, cartStore),
                    ],
                  );
                }
              },
            )),
      ),
    );
  }

  Widget _buildEmptyCartMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 64.0,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Seu carrinho está vazio.',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemsList(BuildContext context, CartStore cartStore) {
    return ListView.builder(
      itemCount: cartStore.cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = cartStore.cartItems[index];

        return Card(
          child: ListTile(
            leading: Image.network(
              cartItem.gemsPack.icon,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image),
            ), // Imagem do produto
            title: Text(cartItem.gemsPack.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantidade: ${cartItem.quantity}'),
                if (cartItem.gemsPack.totalPrice > 0)
                  Text('Preço: ${cartItem.gemsPack.totalPrice}'),
                if (cartItem.gemsPack.gems > 0)
                  Text('Gemas: ${cartItem.gemsPack.gems}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cartStore.removeFromCart(cartItem.gemsPack.id);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCartSummary(BuildContext context, CartStore cartStore) {
    final currencyFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Preço total:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Observer(
                builder: (_) => Text(
                  currencyFormat.format(cartStore.totalMoney),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total de Gemas:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Observer(
                builder: (_) => Text('${cartStore.totalGems}'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentDataScreen()),
                );
              },
              child: const Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }
}
