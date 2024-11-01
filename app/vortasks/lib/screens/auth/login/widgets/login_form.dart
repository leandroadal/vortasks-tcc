import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/auth/widgets/error_box.dart';
import 'package:vortasks/screens/backup/backup_conflict_screen.dart';
import 'package:vortasks/screens/home/home_screen.dart';
import 'package:vortasks/screens/sync/progress_conflict_screen.dart';
import 'package:vortasks/screens/widgets/custom_textfield.dart';
import 'package:vortasks/screens/auth/register/signup_screen.dart';
import 'package:vortasks/stores/backup/backup_store.dart';
import 'package:vortasks/stores/auth/login_store.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.colorScheme,
    required this.loginStore,
  });

  final ColorScheme colorScheme;
  final LoginStore loginStore;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void dispose() {
    widget.loginStore.clear(); // Limpa os campos do SignUpStore
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Card(
          color: widget.colorScheme.primaryContainer,
          margin: const EdgeInsets.all(25),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPasswordField(),
                _buildLoginButton(),
                _buildError(),
                const Divider(),
                _buildSignUpButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Observer _buildEmailField() {
    return Observer(builder: (_) {
      return CustomTextField(
        label: 'E-mail ou Username',
        errorText: widget.loginStore.loginFieldError,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          // Atualiza o email no loginStore
          widget.loginStore.setLoginField(value);
        },
      );
    });
  }

  Observer _buildPasswordField() {
    return Observer(builder: (_) {
      return CustomTextField(
        label: 'Senha',
        errorText: widget.loginStore.passwordError,
        obscureText: true,
        onChanged: (value) {
          // Atualiza a senha
          widget.loginStore.setPassword(value);
        },
        /*
        trailing: GestureDetector(
          //TODO: implementar o Esqueceu sua senha
          child: Text(
            'Esqueceu sua senha?',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: widget.colorScheme.onSecondaryContainer,
            ),
          ),
          onTap: () {},
        ),*/
      );
    });
  }

  Observer _buildLoginButton() {
    return Observer(builder: (_) {
      return Container(
        height: 40,
        margin: const EdgeInsets.only(top: 20, bottom: 12),
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                  Color(0xFF1565C0))), //Color(0xFF1565C0)

          onPressed: () async {
            try {
              final backupStore = GetIt.I<BackupStore>();
              final progressStore = GetIt.I<ProgressStore>();

              await widget.loginStore.loginPressed!() as Future<void>
                  Function()?;

              SchedulerBinding.instance.addPostFrameCallback((_) async {
                if (progressStore.hasConflict) {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ProgressConflictScreen()),
                  );
                }

                if (backupStore.hasConflict) {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => BackupConflictScreen()),
                  );
                }

                if (widget.loginStore.error == null &&
                    !progressStore.hasConflict &&
                    !backupStore.hasConflict) {
                  if (backupStore.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          backupStore.error!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  ); // Fecha a tela de login se não houver conflitos
                }
              });
            } catch (e) {
              log('Erro no login: $e', level: 1000);
            }
          },
          child: widget.loginStore.loading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : const Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white70),
                ),
        ),
      );
    });
  }

  Padding _buildSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          const Text(
            'Não tem uma conta? ',
            style: TextStyle(
                fontSize: 16, color: Color.fromARGB(255, 140, 85, 177)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SignUpScreen()));
            },
            child: const Text(
              'Cadastre-se',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.purple,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  Observer _buildError() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ErrorBox(
          message: widget.loginStore.error,
        ),
      );
    });
  }
}
