import 'package:flutter/cupertino.dart';
import 'package:functional_rx_bloc/view/screen/auth/auth_screen_builder.dart';
import 'package:functional_rx_bloc/view/screen/auth/form/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      AuthScreenBuilder(builder: (context) => const SignInForm());
}
