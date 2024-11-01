import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/controllers/shop/product_controller.dart';
import 'package:vortasks/core/data/Icon_manager.dart';
import 'package:vortasks/models/shop/product.dart';
import 'package:vortasks/screens/shop/not_logged_in_message.dart';
import 'package:vortasks/screens/widgets/my_app_bar.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:vortasks/stores/user_store.dart';

class PurchasedProductsScreen extends StatelessWidget {
  const PurchasedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userStore = GetIt.I<UserStore>();
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: const MyAppBar(title: 'Meus Itens'),
      bottomNavigationBar: isSmallScreen ? const MyBottomNavigationBar() : null,
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            if (userStore.isLoggedIn) {
              // Se estiver logado, busca a lista dos produtos comprados na API
              return FutureBuilder<List<Product>>(
                future: ProductController().getPurchasedProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else {
                    final purchasedProducts = snapshot.data;
                    if (purchasedProducts == null ||
                        purchasedProducts.isEmpty) {
                      return _buildEmptyListMessage(context);
                    } else {
                      return ListView.builder(
                        itemCount: purchasedProducts.length,
                        itemBuilder: (context, index) {
                          final product = purchasedProducts[index];
                          print(product.id);
                          return _buildProductItem(product, context);
                        },
                      );
                    }
                  }
                },
              );
            } else {
              // Se não estiver logado, exibe a mensagem para fazer login
              return NotLoggedInMessage(
                context: context,
                message:
                    'Você precisa estar logado para ver seus itens comprados.',
              );
            }
          },
        ),
      ),
    );
  }

  // Widget para exibir uma mensagem quando a lista de produtos estiver vazia
  Widget _buildEmptyListMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag,
            size: 64.0,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Você ainda não comprou nenhum item.',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  // Widget para cada item da lista de produtos comprados
  Widget _buildProductItem(Product product, BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: FutureBuilder<String?>(
          future: IconManager().getLocalIconPath(product.icon),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data != null) {
              return Image.file(File(snapshot.data!));
            } else {
              return const Icon(Icons.error);
            }
          },
        ),
        title: Text(product.name),
        subtitle: Text(product.description),
      ),
    );
  }
}
