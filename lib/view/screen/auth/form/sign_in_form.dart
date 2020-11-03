import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_authentication_event.dart';
import 'package:functional_rx_bloc/view/components/common/field/email_field.dart';
import 'package:functional_rx_bloc/view/components/common/field/password_field.dart';
import 'package:functional_rx_bloc/view/components/layout/form/form_wrapper.dart';
import 'package:functional_rx_bloc/view/helpers/constants/route_path.dart';
import 'package:functional_rx_bloc/view/screen/auth/auth_viewmodel.dart';
import 'package:functional_rx_bloc/view/screen/auth/bloc/try_auth_bloc.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatelessWidget {
  const SignInForm();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      builder: (context, child) => FormWrapper(
        children: [
          Consumer<AuthViewModel>(
            builder: (_, vm, __) => EmailField(
                errorText: vm.emailErrorText, controller: vm.emailController),
          ),
          Consumer<AuthViewModel>(
            builder: (_, vm, __) => PasswordField(
                errorText: vm.passwordErrorText,
                controller: vm.passwordController,
                formKey: const Key('password')),
          ),
          _SignInButton(),
          RaisedButton(
            child: Text(AppLocalizations.of(context).navSignUp),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(RoutePath.signUp))
        ],
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<AuthViewModel>(
      key: GlobalKey(),
      builder: (_, vm, __) => RaisedButton(
          key: GlobalKey(),
          child: Text(
            AppLocalizations.of(context).labelSignIn,
            key: GlobalKey(),
          ),
          // validateState.canSubmit ? : null;
          onPressed: vm.canSubmit()
              ? () => Provider.of<TryAuthBloc>(context, listen: false)
                  .add(SignIn(email: vm.email, password: vm.password))
              : null));
}
