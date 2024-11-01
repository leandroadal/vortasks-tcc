import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vortasks/screens/auth/login/login_screen.dart';
import 'package:vortasks/screens/social/friends/widgets/friend_item.dart';
import 'package:vortasks/screens/social/friends/add_friend_screen.dart';
import 'package:vortasks/screens/social/friends/friend_requests_screen.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:vortasks/stores/social/friend_request_store.dart';
import 'package:vortasks/stores/social/friend_store.dart';
import 'package:vortasks/stores/user_store.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final FriendStore friendStore = GetIt.I<FriendStore>();
  final FriendRequestStore friendRequestStore = GetIt.I<FriendRequestStore>();

  // Controlador para o RefreshIndicator
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    friendRequestStore
        .loadFriendRequests(); // Carrega as solicitações na inicialização
    WidgetsBinding.instance.addPostFrameCallback((_) {
      friendStore.loadFriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Amigos'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão 'Solicitações' com indicador de novas solicitações
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FriendRequestsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Observer(
                    builder: (_) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(' Solicitações '),
                          // Indicador visual para novas solicitações
                          if (friendRequestStore.receivedRequests.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Lista de amigos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Lista de amigos com RefreshIndicator
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: false,
                header: const WaterDropHeader(),
                onRefresh: () async {
                  await friendStore.loadFriends();
                  _refreshController.refreshCompleted();
                },
                child: Observer(
                  builder: (_) {
                    if (friendStore.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (friendStore.error != null) {
                      // Verifica se o erro é "Token Inválido" e redireciona para a tela de login
                      if (friendStore.error == 'Token Inválido' && mounted) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        });
                        friendStore.setError(null);
                        return Container();
                      }

                      // Se o erro não for 403, exibe o ícone de recarregar e a mensagem de erro
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                friendStore.setError(null);
                                friendStore.loadFriends();
                              },
                              icon: const Icon(Icons.refresh, size: 48.0),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              friendStore.error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      );
                    } else if (friendStore.friendships.isEmpty) {
                      return const Center(
                        child: Text('Você ainda não tem amigos.'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: friendStore.friendships.length,
                        itemBuilder: (context, index) {
                          final friendship = friendStore.friendships[index];
                          final friend = friendship.users.firstWhere(
                            (user) => user.id != GetIt.I<UserStore>().user!.id,
                          );
                          return FriendItem(
                              context: context,
                              friend: friend,
                              friendshipId: friendship.id,
                              friendStore: friendStore);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isSmallScreen
          ? FloatingActionButton(
              onPressed: () {
                friendStore.setError('');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddFriendScreen()),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.person_add),
            )
          : null,
      bottomNavigationBar: isSmallScreen ? const MyBottomNavigationBar() : null,
    );
  }
}
