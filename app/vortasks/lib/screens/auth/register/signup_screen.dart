import 'package:flutter/material.dart';
import 'package:vortasks/screens/auth/register/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
        backgroundColor: colorScheme.primaryContainer,
      ),
      body: SignUpForm(colorScheme: colorScheme),
    );
  }
}
