import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/auth/auth_controller.dart';
import 'package:vortasks/controllers/user_controller.dart';
import 'package:vortasks/models/user/dto/register_dto.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';
part 'signup_store.g.dart';

class SignUpStore = SignUpStoreBase with _$SignUpStore;

abstract class SignUpStoreBase with Store {
  @observable
  String? name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name!.length > 6 && name!.length < 120;
  String? get nameError {
    if (name == null || nameValid) {
      return null;
    } else if (name!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Nome muito curto';
    }
  }

  @observable
  String? nickName;

  @action
  void setNickName(String value) => nickName = value;

  @computed
  bool get nickNameValid =>
      nickName != null && nickNameRegExp.hasMatch(nickName!);
  String? get nickNameError {
    if (nickName == null || nickNameValid) {
      return null;
    } else if (nickName!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Nome de usuário inválido\n'
          '\n  - O nome de usuário deve ter\n'
          '    pelo menos 6 caracteres,\n'
          '\n  - não deve ter caracteres especiais\n'
          '    (ex.: _, @, %, etc.).\n';
    }
  }

  final nickNameRegExp = RegExp(r'^[a-zA-Z0-9]{6,}$');

  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && emailRegExp.hasMatch(email!);
  String? get emailError {
    if (email == null || emailValid) {
      return null;
    } else if (email!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'E-mail inválido';
    }
  }

  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @observable
  String? pass1;

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => pass1 != null && senhaRegExp.hasMatch(pass1!);
  String? get pass1Error {
    if (pass1 == null || pass1Valid) {
      return null;
    } else if (pass1!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Senha inválida.\n'
          '\n  - A senha deve ter pelo menos 8 caracteres,\n'
          '\n  - Deve conter uma letra maiúscula.\n'
          '\n  - Deve conter uma letra minúscula.\n'
          '\n  - um caractere especial (ex.: _, @, %, etc.).\n'
          '\n  - Deve conter um número.';
    }
  }

  final senhaRegExp = RegExp(
      r'''^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$''');

  @observable
  String? pass2;

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get pass2Valid => pass2 != null && pass2 == pass1;
  String? get pass2Error {
    // o Botão não ficara disponível quando os campos for = a null
    if (pass2 == null || pass2Valid) {
      return null;
    } else {
      return 'Senhas não coincidem';
    }
  }

  @computed
  bool get isFormValid =>
      nameValid && nickNameValid && emailValid && pass1Valid && pass2Valid;

  @observable
  bool loading = false;

  @observable
  String? error;

  @action
  setError(String value) => error = value;

  @action
  Future<void> signUp() async {
    loading = true;

    final user = RegisterDTO(
        name: name!, email: email!, password: pass1!, username: nickName!);

    try {
      AuthController authController = AuthController();
      await authController.register(user.toJson());
      bool isLoginSuccessful = await authController.login({
        'username': nickName,
        'password': pass1,
      });

      if (isLoginSuccessful) {
        await UserController().userInfo();
        // Envia logo pro remote pois ao criar conta com certeza não terá dados mais atuais que o local

        await GetIt.I<ProgressStore>().syncAfterRegister();
      }
    } finally {
      loading = false;
    }
  }

  @action
  void clear() {
    name = null;
    nickName = null;
    email = null;
    pass1 = null;
    pass2 = null;
    error = null;
  }
}
