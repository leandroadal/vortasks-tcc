import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/shop/gems_package.dart';
import 'package:vortasks/screens/shop/cart_screen.dart';
import 'package:vortasks/stores/shop/cart_store.dart';

class GemsPackageDialog extends StatefulWidget {
  final List<GemsPackage> gemsPackages;
  final int initialIndex;

  const GemsPackageDialog({
    super.key,
    required this.gemsPackages,
    required this.initialIndex,
  });

  @override
  State<GemsPackageDialog> createState() => _GemsPackageDialogState();
}

class _GemsPackageDialogState extends State<GemsPackageDialog> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final cartStore = GetIt.I<CartStore>();
    final gemsPackage = widget.gemsPackages[currentIndex];
    final hasDiscount = gemsPackage.discountPercentage > 0;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          // Permite rolagem caso o conteúdo seja muito grande
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    'https://gemanativa.com/wp-content/uploads/2024/03/ilustracao-gemas-1-1024x628.jpg',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  if (hasDiscount)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '-${(gemsPackage.discountPercentage).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                gemsPackage.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Quantidade:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Icon(
                    Icons.diamond,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                  Text(
                    '${gemsPackage.gems}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (hasDiscount)
                Text(
                  'De: R\$ ${(gemsPackage.money).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              Text(
                'Por: R\$ ${gemsPackage.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: hasDiscount ? Colors.red : null,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: currentIndex > 0
                        ? () => setState(() => currentIndex--)
                        : null,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Adiciona o pacote de gemas ao carrinho
                      cartStore.addToCart(gemsPackage);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));
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
                    onPressed: currentIndex < widget.gemsPackages.length - 1
                        ? () => setState(() => currentIndex++)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
