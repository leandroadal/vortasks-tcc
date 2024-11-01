import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/stores/social/group_task_invite_store.dart';
import 'package:vortasks/screens/auth/login/login_screen.dart';
import 'package:vortasks/screens/social/grouptask/widgets/group_task_request_item.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';

class GroupTaskRequestsScreen extends StatefulWidget {
  const GroupTaskRequestsScreen({super.key});

  @override
  State<GroupTaskRequestsScreen> createState() =>
      _GroupTaskRequestsScreenState();
}

class _GroupTaskRequestsScreenState extends State<GroupTaskRequestsScreen> {
  final GroupTaskInviteStore inviteStore = GetIt.I<GroupTaskInviteStore>();

  @override
  void initState() {
    super.initState();
    inviteStore.loadInvites(); // Carrega os convites na inicialização
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Convites para Tarefas em Grupo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            if (inviteStore.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (inviteStore.error != null) {
              // Verifica se o erro é "Token inválido" e redireciona para a tela de login
              if (inviteStore.error == 'Token inválido' && mounted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                });
                return Container(); // Retorna um Container vazio enquanto redireciona
              }

              // Se o erro não for token invalido, exibe o ícone de recarregar e a mensagem de erro
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        inviteStore.setError(null);
                        inviteStore.loadInvites();
                      },
                      icon: const Icon(Icons.refresh, size: 48.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      inviteStore.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );
            } else if (inviteStore.invites.isEmpty) {
              return const Center(
                child: Text('Você não tem convites para tarefas em grupo.'),
              );
            } else {
              final pendingInvites = inviteStore.invites
                  .where((invite) => invite.status == 'PENDING')
                  .toList();

              if (pendingInvites.isEmpty) {
                return const Center(
                  child: Text(
                      'Você não tem convites pendentes para tarefas em grupo.'),
                );
              } else {
                return ListView.builder(
                  itemCount: pendingInvites.length,
                  itemBuilder: (context, index) {
                    final invite = pendingInvites[index];
                    return GroupTaskRequestItem(
                      invite: invite,
                      backgroundColor: Colors.indigo[700],
                      color: Colors.white,
                    );
                  },
                );
              }
            }
          },
        ),
      ),
      bottomNavigationBar: isSmallScreen ? const MyBottomNavigationBar() : null,
    );
  }
}
