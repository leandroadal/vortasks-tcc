import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/social/friend_invite.dart';
import 'package:vortasks/stores/social/friend_request_store.dart';

class FriendRequestItem extends StatelessWidget {
  final FriendInvite friendInvite;
  final bool
      isReceived; // Indica se a solicitação foi recebida (true) ou enviada (false)
  final Color? color;
  final Color? backgroundColor;

  const FriendRequestItem({
    super.key,
    required this.friendInvite,
    required this.isReceived,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final friendRequestStore = GetIt.I<FriendRequestStore>();

    // Chama a ação para buscar o nome de usuário na inicialização do widget
    final userId = isReceived ? friendInvite.senderId : friendInvite.receiverId;

    return FutureBuilder(
      // Usa FutureBuilder para lidar com o Future
      future: friendRequestStore.fetchUsername(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            // Exibe um ListTile com indicador de carregamento
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('Carregando...'),
          );
        } else if (snapshot.hasError) {
          return ListTile(
            // Exibe um ListTile com mensagem de erro
            leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('Erro: ${snapshot.error}'),
          );
        } else {
          // Nome de usuário disponível, constrói o ListTile normal
          return Card(
            color:
                backgroundColor ?? Theme.of(context).colorScheme.inversePrimary,
            margin: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Observer(
                builder: (_) {
                  final username = friendRequestStore.usernames[userId];
                  return Text(
                    username ??
                        'Usuário não encontrado', // Exibe um texto padrão se o nome de usuário for nulo
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              trailing: isReceived
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: color),
                          onPressed: () async {
                            await friendRequestStore
                                .acceptFriendRequest(friendInvite.senderId);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: color),
                          onPressed: () async {
                            await friendRequestStore
                                .rejectFriendRequest(friendInvite.senderId);
                          },
                        ),
                      ],
                    )
                  : OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Pendente',
                        style: TextStyle(color: color),
                      ),
                    ),
            ),
          );
        }
      },
    );
  }
}
