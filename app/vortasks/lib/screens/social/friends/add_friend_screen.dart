import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/auth/login/login_screen.dart';
import 'package:vortasks/screens/auth/widgets/error_box.dart';
import 'package:vortasks/screens/widgets/custom_textfield.dart';
import 'package:vortasks/stores/social/friend_store.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _friendStore = GetIt.I<FriendStore>();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Amigo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                label: 'Nome de Usuário do Amigo',
                onChanged: (value) => _usernameController.text = value,
                errorText: _friendStore.error,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final username = _usernameController.text;
                    await _friendStore.addFriend(username);
                    // Verifica se a mensagem de erro corresponde a "Token inválido"
                    if (_friendStore.error == 'Token inválido' && mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    } else if (_friendStore.error == null) {
                      _showSuccessDialog(context);
                    }
                  }
                },
                child: const Text('Enviar Solicitação'),
              ),
              _friendStore.error != null && _friendStore.error!.isNotEmpty
                  ? Observer(builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ErrorBox(
                          message: _friendStore.error,
                        ),
                      );
                    })
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          title: const Center(
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 48.0,
            ),
          ),
          content: const Text(
            'Solicitação de amizade enviada com sucesso!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                Navigator.of(context).pop(); // Fecha a tela de adicionar amigo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
