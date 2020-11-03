import 'package:flutter/cupertino.dart';
import 'package:functional_rx_bloc/view/screen/auth/auth_screen_builder.dart';
import 'package:functional_rx_bloc/view/screen/auth/form/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      AuthScreenBuilder(builder: (context) => const SignUpForm());
}
