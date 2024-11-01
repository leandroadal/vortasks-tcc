import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/home/home_screen.dart';
import 'package:vortasks/screens/rewards/rewards_screen.dart';
import 'package:vortasks/screens/shop/shop_screen.dart';
import 'package:vortasks/screens/tasks/tasks_screen.dart';
import 'package:vortasks/stores/page_store.dart';
import 'package:vortasks/stores/user_store.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pageStore = GetIt.I<PageStore>();
    final userStore = GetIt.I<UserStore>(); // Obtenha o UserStore

    return Observer(builder: (_) {
      // Crie a lista de BottomNavigationBarItems
      List<BottomNavigationBarItem> bottomNavItems = [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: 'Tarefas'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag), label: 'Loja'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch), label: 'Recompensas'),
      ];

      return BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        unselectedItemColor:
            Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
        // Use a lista de itens criada
        items: bottomNavItems,
        currentIndex: pageStore.selectedPage,
        onTap: (index) {
          // Navegue para a página correspondente ao índice
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => pageByIndex(index, userStore.isLoggedIn),
          ));
          pageStore.setPage(index);
        },
      );
    });
  }

  // Função para retornar a página com base no índice e no status de login
  Widget pageByIndex(int index, bool isLoggedIn) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const TasksScreen();
      case 2:
        return const LojaScreen();
      case 3:
        return RewardsScreen();
      default:
        return const HomeScreen();
    }
  }
}
