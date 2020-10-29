// 画面のモードの管理(sign in,sign up,reset password,oAuth)
// viewの input controller の保持と破棄

import 'package:flutter/cupertino.dart';

enum AuthViewMode {
  signIn,
  signUp,
  signInWithSocialService,
  resetPassword,
}

class AuthViewModel extends ChangeNotifier {
  AuthViewModel()
      : emailController = TextEditingController(),
        passwordController = TextEditingController();
  final TextEditingController emailController;
  final TextEditingController passwordController;
  String get email => emailController.text;
  String get password => passwordController.text;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
