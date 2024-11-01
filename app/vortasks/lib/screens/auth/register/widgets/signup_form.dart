import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/exceptions/conflict_exception.dart';
import 'package:vortasks/exceptions/sync_exception.dart';
import 'package:vortasks/screens/auth/widgets/error_box.dart';
import 'package:vortasks/screens/home/home_screen.dart';
import 'package:vortasks/screens/sync/progress_conflict_screen.dart';
import 'package:vortasks/screens/widgets/custom_textfield.dart';
import 'package:vortasks/stores/auth/signup_store.dart';
import 'package:vortasks/stores/user_store.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final SignUpStore signUpStore = GetIt.I<SignUpStore>();
  late ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = reaction((_) => GetIt.I<UserStore>().isLoggedIn, (isLogged) {
      if (isLogged && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });

    disposer = reaction(
      (_) => signUpStore.error,
      (error) {
        if (error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    disposer();
    signUpStore.clear(); // Limpa os campos do SignUpStore
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                _buildNameField(),
                const SizedBox(height: 16),
                _buildNickNameField(),
                const SizedBox(height: 16),
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPasswordField(),
                _buildConfirmPasswordField(),
                _buildError(),
                _buildSignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Observer _buildNameField() {
    return Observer(builder: (_) {
      return CustomTextField(
        label: 'Nome',
        errorText: signUpStore.nameError,
        keyboardType: TextInputType.name,
        onChanged: (value) => signUpStore.setName(value),
      );
    });
  }

  Observer _buildNickNameField() {
    return Observer(builder: (_) {
      return CustomTextField(
        label: 'Nome de Usuário',
        errorText: signUpStore.nickNameError,
        keyboardType: TextInputType.text,
        onChanged: (value) => signUpStore.setNickName(value),
      );
    });
  }

  Observer _buildEmailField() {
    return Observer(builder: (_) {
      return CustomTextField(
        label: 'E-mail',
        errorText: signUpStore.emailError,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => signUpStore.setEmail(value),
      );
    });
  }

  Observer _buildPasswordField() {
    return Observer(builder: (_) {
      return CustomTextField(
        label: 'Senha',
        errorText: signUpStore.pass1Error,
        obscureText: true,
        onChanged: (value) => signUpStore.setPass1(value),
      );
    });
  }

  Observer _buildConfirmPasswordField() {
    return Observer(builder: (_) {
      return CustomTextField(
        label: 'Repita a Senha',
        errorText: signUpStore.pass2Error,
        obscureText: true,
        onChanged: (value) => signUpStore.setPass2(value),
      );
    });
  }

  Observer _buildError() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ErrorBox(
          message: signUpStore.error,
        ),
      );
    });
  }

  Observer _buildSignUpButton() {
    return Observer(builder: (_) {
      return Container(
        height: 40,
        margin: const EdgeInsets.only(top: 20, bottom: 12),
        child: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF1565C0)),
          ),
          onPressed: signUpStore.isFormValid && !signUpStore.loading
              ? () async {
                  try {
                    await signUpStore.signUp();
                    //Navigator.of(context).pop();
                  } catch (e) {
                    if (e is ConflictException) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProgressConflictScreen(),
                        ),
                      );
                    } else if (e is BadTokenException) {
                      await signUpStore.signUp();
                    } else if (e is SyncException) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Erro ao sincronizar.'),
                        ),
                      );
                    }
                  }
                }
              : null,
          child: signUpStore.loading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : const Text(
                  'Registrar',
                  style: TextStyle(color: Colors.white70),
                ),
        ),
      );
    });
  }
}
