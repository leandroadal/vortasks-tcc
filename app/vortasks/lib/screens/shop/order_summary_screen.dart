import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:vortasks/controllers/shop/purchase_controller.dart';
import 'package:vortasks/screens/widgets/my_app_bar.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';
import 'package:vortasks/stores/shop/cart_store.dart';
import 'package:vortasks/screens/shop/widgets/order_completed_screen.dart';
import 'package:vortasks/stores/shop/sell_store.dart';

class OrderSummaryScreen extends StatelessWidget {
  final String paymentMethod;
  final String? cardNumber;

  const OrderSummaryScreen({
    super.key,
    required this.paymentMethod,
    this.cardNumber,
  });

  @override
  Widget build(BuildContext context) {
    final cartStore = GetIt.I<CartStore>();
    final currencyFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      appBar: const MyAppBar(title: 'Resumo do Pedido'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumo do Pedido',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // TODO: (Exibir os itens do carrinho)

            const SizedBox(height: 16.0),
            Text('Quantidade de Gemas: ${cartStore.totalGems}'),
            Text('Preço: ${currencyFormat.format(cartStore.totalMoney)}'),

            const SizedBox(height: 16.0),
            Text('Método de Pagamento: $paymentMethod'),
            if (paymentMethod == 'Cartão de Crédito' && cardNumber != null)
              Text(
                'Número do Cartão: **** **** **** ${cardNumber!.substring(cardNumber!.length - 2)}',
              ),

            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                final sellStore = GetIt.I<SellStore>();
                final progressStore = GetIt.I<ProgressStore>();

                // 1. Inicia a transação para cada item no carrinho
                for (var cartItem in cartStore.cartItems) {
                  final transaction = await PurchaseController()
                      .startGemsPurchase(cartItem.gemsPack.id);

                  // 2. Completa a transação
                  await PurchaseController().completeGemsPurchase(
                      transaction.id,
                      cartItem.gemsPack.totalPrice * cartItem.quantity);
                }

                // 3. Atualiza as gemas e moedas (após a compra bem-sucedida)
                sellStore.incrementGems(cartStore.totalGems);
                await progressStore.fromRemote(); // Atualiza o ProgressStore

                // 4. Limpa o carrinho
                cartStore.clearCart();

                if (context.mounted) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderCompletedScreen()),
                  );
                }
              },
              child: const Text('Finalizar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
