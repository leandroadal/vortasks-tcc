import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/auth/login/widgets/login_form.dart';
import 'package:vortasks/stores/auth/login_store.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginStore loginStore = GetIt.I<LoginStore>();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar na conta'),
        centerTitle: true,
        backgroundColor: colorScheme.primaryContainer,
      ),
      body: LoginForm(colorScheme: colorScheme, loginStore: loginStore),
    );
  }
}
