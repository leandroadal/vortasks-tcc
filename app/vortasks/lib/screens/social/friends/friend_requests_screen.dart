import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/auth/login/login_screen.dart';
import 'package:vortasks/screens/social/friends/widgets/friend_request_item.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:vortasks/stores/social/friend_request_store.dart';

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({super.key});

  @override
  State<FriendRequestsScreen> createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
  final FriendRequestStore friendRequestStore = GetIt.I<FriendRequestStore>();

  @override
  void initState() {
    super.initState();
    friendRequestStore
        .loadFriendRequests(); // Carrega as solicitações na inicialização
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitações de Amizade'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            if (friendRequestStore.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (friendRequestStore.error != null) {
              // Verifica se o erro é "Token inválido" e redireciona para a tela de login
              if (friendRequestStore.error == 'Token inválido' && mounted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                });
                return Container(); // Retorna um Container vazio enquanto redireciona
              }

              // Se o erro não for no token, exibe o ícone de recarregar e a mensagem de erro
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        friendRequestStore.setError(null);
                        await friendRequestStore.loadFriendRequests();
                      },
                      icon: const Icon(Icons.refresh, size: 48.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      friendRequestStore.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );
            } else if (friendRequestStore.receivedRequests.isEmpty &&
                friendRequestStore.sentRequests.isEmpty) {
              return const Center(
                child: Text('Você não tem solicitações de amizade.'),
              );
            } else {
              // Se não houver erros e houver solicitações, exibe as listas
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (friendRequestStore.receivedRequests.isNotEmpty) ...[
                    const Text(
                      'Solicitações Recebidas',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: friendRequestStore.receivedRequests.length,
                        itemBuilder: (context, index) {
                          final request =
                              friendRequestStore.receivedRequests[index];
                          return FriendRequestItem(
                            friendInvite: request,
                            isReceived: true,
                            backgroundColor: Colors.indigo[700],
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                  if (friendRequestStore.sentRequests.isNotEmpty) ...[
                    const Text(
                      'Solicitações Enviadas',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: friendRequestStore.sentRequests.length,
                        itemBuilder: (context, index) {
                          final request =
                              friendRequestStore.sentRequests[index];
                          return FriendRequestItem(
                            friendInvite: request,
                            isReceived: false,
                          );
                        },
                      ),
                    ),
                  ],
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: isSmallScreen ? const MyBottomNavigationBar() : null,
    );
  }
}
