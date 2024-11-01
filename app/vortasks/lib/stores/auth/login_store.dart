import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/auth/auth_controller.dart';
import 'package:vortasks/controllers/user_controller.dart';
import 'package:vortasks/exceptions/user_info_exception.dart';
import 'package:vortasks/stores/backup/backup_store.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';
part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  @observable
  String? loginField;

  @action
  void setLoginField(String value) => loginField = value;

  @computed
  bool get loginFieldValid =>
      loginField != null &&
      (emailRegExp.hasMatch(loginField!) ||
          usernameRegExp.hasMatch(loginField!));

  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  final usernameRegExp = RegExp(r'^[a-zA-Z0-9]+$'); // Permite letras e números

  @computed
  String? get loginFieldError => loginField == null || loginFieldValid
      ? null
      : 'E-mail ou nome de usuário inválido';

  @observable
  String? password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && senhaRegExp.hasMatch(password!);
  String? get passwordError => password == null || passwordValid
      ? null
      : 'Senha inválida.\n'
          '\n  - A senha deve ter pelo menos 8 caracteres,\n'
          '\n  - Deve conter uma letra maiúscula.\n'
          '\n  - Deve conter uma letra minúscula.\n'
          '\n  - um caractere especial (ex.: _, @, %, etc.).\n'
          '\n  - Deve conter um número.';

  final senhaRegExp = RegExp(
      r'''^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$''');

  @computed
  Function? get loginPressed =>
      loginFieldValid && passwordValid && !loading ? login : null;

  @observable
  bool loading = false;

  @action
  setLoading(bool value) => loading = value;

  @observable
  String? error;

  @action
  setError(String? value) => error = value;

  @action
  Future<void> login() async {
    loading = true;
    error = null;

    try {
      bool isLoginSuccessful = await AuthController().login({
        'username': loginField!,
        'password': password,
      });
      if (isLoginSuccessful) {
        await UserController().userInfo();
        await GetIt.I<ProgressStore>().syncAfterLogin();
        await GetIt.I<BackupStore>().syncAferLogin();
      }
    } catch (e) {
      if (e is UserInfoException) {
        error = e.message;
      }
    } finally {
      loading = false;
    }
  }

  @action
  void clear() {
    loginField = null;
    password = null;
    error = null;
  }
}
