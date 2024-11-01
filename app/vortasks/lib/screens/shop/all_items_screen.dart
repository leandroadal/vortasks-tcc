import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/shop/widgets/product_card.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:vortasks/stores/shop/shop_store.dart';

class AllItemsScreen extends StatefulWidget {
  const AllItemsScreen({super.key});

  @override
  State<AllItemsScreen> createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  final ShopStore _shopStore = GetIt.I<ShopStore>();
  int _currentPage = 0;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _shopStore.reloadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Itens'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      bottomNavigationBar: isSmallScreen ? const MyBottomNavigationBar() : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            if (_shopStore.productsLoading && _currentPage == 0) {
              return const Center(child: CircularProgressIndicator());
            } else if (_shopStore.productsError != null) {
              return Center(
                child: Text('Erro: ${_shopStore.productsError}'),
              );
            } else {
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification &&
                      notification.metrics.extentAfter == 0 &&
                      !_isLoadingMore) {
                    _loadMore();
                  }
                  return false;
                },
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                  ),
                  itemCount:
                      _shopStore.products.length + (_isLoadingMore ? 3 : 0),
                  itemBuilder: (context, index) {
                    if (index < _shopStore.products.length) {
                      return _buildItemCard(index, context);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _loadMore() async {
    // Se na ultima requisição veio menos de 15 quer dizer que é a ultima pagina
    if (_isLoadingMore || _shopStore.lastPageItemCount < 15) return;

    _isLoadingMore = true;
    _currentPage++;
    log("Carregando página: $_currentPage");

    try {
      await _shopStore.reloadProducts(page: _currentPage);
    } catch (e) {
      log("Erro ao carregar mais itens: $e");
    } finally {
      _isLoadingMore = false;
    }
  }

  Widget _buildItemCard(int productIndex, BuildContext context) {
    return ProductCard(
      shopStore: _shopStore,
      productIndex: productIndex,
    );
  }
}
