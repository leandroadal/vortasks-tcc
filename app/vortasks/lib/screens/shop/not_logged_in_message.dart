import 'package:flutter/material.dart';
import 'package:vortasks/screens/auth/login/login_screen.dart';

class NotLoggedInMessage extends StatelessWidget {
  const NotLoggedInMessage({
    super.key,
    required this.context,
    required this.message,
  });

  final BuildContext context;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('Entrar'),
          ),
        ],
      ),
    );
  }
}
