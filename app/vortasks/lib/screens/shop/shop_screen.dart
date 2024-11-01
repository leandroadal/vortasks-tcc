import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/shop/gems_package.dart';
import 'package:vortasks/screens/shop/not_logged_in_message.dart';
import 'package:vortasks/screens/widgets/my_app_bar.dart';
import 'package:vortasks/screens/shop/all_items_screen.dart';
import 'package:vortasks/screens/shop/widgets/gems_pack_dialog.dart';
import 'package:vortasks/screens/shop/widgets/product_card.dart';
import 'package:vortasks/screens/shop/purchased_products_screen.dart';
import 'package:vortasks/stores/shop/sell_store.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:vortasks/stores/shop/shop_store.dart';
import 'package:vortasks/stores/user_store.dart';

class LojaScreen extends StatefulWidget {
  const LojaScreen({super.key});

  @override
  State<LojaScreen> createState() => _LojaScreenState();
}

class _LojaScreenState extends State<LojaScreen> {
  final SellStore _sellStore = GetIt.I<SellStore>();
  final UserStore _userStore = GetIt.I<UserStore>();
  final ShopStore _shopStore = GetIt.I<ShopStore>();

  @override
  void initState() {
    super.initState();
    _shopStore.mostPopularProducts(); // Carrega os itens populares
    _shopStore.loadGemsPackages();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 600;
    return Scaffold(
      appBar: const MyAppBar(title: 'Loja'),
      body: SingleChildScrollView(
        // Torna a página inteira rolável
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Observer(
            builder: (_) {
              if (_userStore.isLoggedIn) {
                return _buildLoggedInContent(context);
              } else {
                return NotLoggedInMessage(
                  context: context,
                  message: 'Você precisa estar logado para ver a Loja.',
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: isSmallScreen ? const MyBottomNavigationBar() : null,
      floatingActionButton: _buildMyItemsButton(context),
    );
  }

  Widget _buildMyItemsButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PurchasedProductsScreen()),
        );
      },
      icon: const Icon(Icons.shopping_bag),
      label: const Text('Meus Itens'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        //foregroundColor: Colors.white, // Cor do texto
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          // Bordas arredondadas
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Column _buildLoggedInContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        _buildCurrencyDisplay(_sellStore.gems, _sellStore.coins, context),
        const SizedBox(height: 32.0),

        _buildSectionTitle('Adquirir itens', context, seeMoreAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AllItemsScreen()),
          );
        }),
        const SizedBox(height: 16.0),
        _handleItensSection(context),
        const SizedBox(height: 32.0),
        _buildSectionTitle('Comprar gemas', context),
        const SizedBox(height: 16.0),
        // Grade de itens (não rolável)
        _handleGemsSection(context),
        const SizedBox(height: 32.0), // Espaçamento extra no final
      ],
    );
  }

  Observer _handleItensSection(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_shopStore.productsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_shopStore.productsError != null) {
          return _buildErrorSection(_shopStore.productsError!,
              () => _shopStore.reloadProducts(), context);
        } else if (_shopStore.popularProducts.isEmpty) {
          return const Center(
            child: Text('Não existem produtos disponíveis para compra'),
          );
        } else {
          return SizedBox(
            //height: 250,
            child: _buildItemGrid(3, context),
          );
        }
      },
    );
  }

  Observer _handleGemsSection(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_shopStore.gemsPackagesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_shopStore.gemsPackagesError != null) {
          return _buildErrorSection(_shopStore.gemsPackagesError!,
              () => _shopStore.loadGemsPackages(), context);
        } else if (_shopStore.gemsPackages.isEmpty) {
          return const Center(
            child: Text('Não existem pacotes de gemas disponíveis para compra'),
          );
        } else {
          return SizedBox(
            height: 250,
            child: _buildGemsGrid(3, context),
          );
        }
      },
    );
  }

  GridView _buildItemGrid(int crossAxisCount, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // Impede que a grade cresça além do necessário
      physics:
          const NeverScrollableScrollPhysics(), // Desativa a rolagem da grade

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount:
          _shopStore.popularProducts.length, // Exibe os 6 primeiros itens
      itemBuilder: (context, index) {
        return _buildItemCard(index, context, popular: true);
      },
    );
  }

  GridView _buildGemsGrid(int crossAxisCount, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: _shopStore.gemsPackages.length, // Exibe os 6 primeiros itens
      itemBuilder: (context, index) {
        final gemsPackage = _shopStore.gemsPackages[index];
        return _buildGemsCard(gemsPackage, context);
      },
    );
  }

  ProductCard _buildItemCard(int productIndex, BuildContext context,
      {bool popular = false}) {
    return ProductCard(
      shopStore: _shopStore,
      productIndex: productIndex,
      popular: popular,
    );
  }

  Card _buildGemsCard(GemsPackage gemsPackage, BuildContext context) {
    final hasDiscount =
        gemsPackage.discountPercentage > 0; // Verifica se tem desconto
    return Card(
      child: InkWell(
        onTap: () {
          // ação ao tocar no pacote de gemas
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return GemsPackageDialog(
                gemsPackages: _shopStore.gemsPackages,
                initialIndex: _shopStore.gemsPackages.indexOf(gemsPackage),
              );
            },
          );
        },
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' ${gemsPackage.gems}',
                  style: const TextStyle(fontSize: 12.0),
                ),
                const Icon(
                  Icons.diamond,
                  size: 40.0,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 5.0),
                Text(
                  '${gemsPackage.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: Colors.lightGreen,
                      size: 20,
                    ),
                    Text(
                      'R\$ ${gemsPackage.money.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
            if (hasDiscount) // Posiciona a tag de desconto se houver algum
              Positioned(
                top: 41,
                right: 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '-${(gemsPackage.discountPercentage).toInt()}%',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDisplay(int gems, int coins, BuildContext context) {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.diamond,
                  color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 8.0),
              Text(
                'Gemas: $gems',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                'assets/icons/shop/money-icon.png',
                height: 25,
                width: 25,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Moedas: $coins',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildSectionTitle(String title, BuildContext context,
      {VoidCallback? seeMoreAction}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        if (seeMoreAction != null)
          TextButton(
            onPressed: seeMoreAction,
            child: const Text('Ver mais'),
          ),
      ],
    );
  }

  Widget _buildErrorSection(
      String errorMessage, VoidCallback retryAction, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          IconButton(
            icon: const Icon(Icons.refresh, size: 32.0),
            onPressed: retryAction,
          ),
        ],
      ),
    );
  }
}
