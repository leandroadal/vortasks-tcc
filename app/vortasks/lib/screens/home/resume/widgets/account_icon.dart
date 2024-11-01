import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/auth/login/login_screen.dart';
import 'package:vortasks/screens/auth/widgets/error_box.dart';
import 'package:vortasks/stores/auth/logout_store.dart';
import 'package:vortasks/stores/user_store.dart';

class AccountIcon extends StatelessWidget {
  const AccountIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final UserStore userStore = GetIt.I<UserStore>();

    return GestureDetector(
      onTap: () {
        if (userStore.isLoggedIn) {
          _showAccountInfo(context, userStore);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      },
      child: const CircleAvatar(
        radius: 20.0,
        child: Icon(Icons.account_circle, size: 30.0),
      ),
    );
  }

  void _showAccountInfo(BuildContext context, UserStore userStore) {
    final LogoutStore loginStore = GetIt.I<LogoutStore>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informações da Conta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Observer(builder: (_) {
                return ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: Text(userStore.name ?? 'Nome não encontrado'),
                );
              }),
              Observer(builder: (_) {
                return ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(userStore.email ?? 'Email não encontrado'),
                );
              }),
              _buildError(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await loginStore.logoutUser();
                if (loginStore.logoutError == null) Navigator.of(context).pop();
              },
              child: const Text('Sair da conta'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Observer _buildError() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ErrorBox(
          message: GetIt.I<LogoutStore>().logoutError,
        ),
      );
    });
  }
}
