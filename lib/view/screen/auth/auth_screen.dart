import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_event.dart';
import 'package:functional_rx_bloc/view/bloc/auth/auth_bloc.dart';
import 'package:functional_rx_bloc/view/components/common/field/email_field.dart';
import 'package:functional_rx_bloc/view/components/common/field/password_field.dart';
import 'package:functional_rx_bloc/view/screen/auth/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
          builder: (context, child) => Consumer<AuthViewModel>(
                // wrap with authValidationBloc
                builder: (context, viewmodel, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(message !=null) ...[Text(message)],
                    EmailField(
                        //onChanged: Provider.of<AuthValidationBloc>(context).add(MaybeSignInParams(email,password)),
                        controller: viewmodel.emailController),
                    PasswordField(
                        //onChanged: Provider.of<AuthValidationBloc>(context).add(MaybeSignInParams(email,password)),
                        controller: viewmodel.passwordController,
                        formKey: GlobalKey()),
                    RaisedButton(
                        child: Text(AppLocalizations.of(context).labelSignIn),
                        // validateState.canSubmit ? : null;
                        onPressed: () =>
                            Provider.of<AuthBloc>(context, listen: false).add(
                                SignIn(
                                    email: viewmodel.email,
                                    password: viewmodel.password)))
                  ],
                ),
              )),
    );
  }
}
