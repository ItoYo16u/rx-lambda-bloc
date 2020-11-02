// 画面のモードの管理(sign in,sign up,reset password,oAuth)
// viewの input controller の保持と破棄
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation.dart';
import 'package:flutter/cupertino.dart';

enum AuthViewState {
  signIn,
  signUp,
  signInWithSocialService,
  resetPassword,
}
/// signIn/Up/resetPasswordはviewModelで切り替える.
///
/// (blocでやると、(signIn,signUp,resetPassword)x(ready,pending,success,failure)となってややこしい)
class AuthViewModel extends ChangeNotifier {
  AuthViewModel()
      : emailController = TextEditingController(),
        passwordController = TextEditingController() {
    emailController.addListener(updateEmailErrorText);
    passwordController.addListener(updatePasswordErrorText);
  }

  final TextEditingController emailController;
  final TextEditingController passwordController;
  AuthViewState authViewState = AuthViewState.signIn;

  void updateAuthViewState({@required AuthViewState state}){
    authViewState = state;
    notifyListeners();
  }

  String get email => emailController.text;

  String get password => passwordController.text;

  String passwordErrorText;
  String emailErrorText;

  bool canSubmit() =>
      email.isEmail().isValid() && password.isPassword().isValid();

  void updateEmailErrorText() {
    emailErrorText = email.isEmail().validate();
    notifyListeners();
  }

  void updatePasswordErrorText() {
    passwordErrorText = password.isPassword().validate();
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
