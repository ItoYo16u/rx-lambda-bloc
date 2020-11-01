import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_state.dart';
import 'package:functional_rx_bloc/view/bloc/auth/auth_bloc.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({@required this.privateApp, @required this.redirect});

  final Widget privateApp;
  final Widget Function({@required BuildContext context, String message})
      redirect;

  @override
  Widget build(BuildContext context) {
    // try auto login;
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (before,after)=>before != after,
        builder: (context, state) {
      if (state is NotAuthenticated) {
        return redirect(context: context, message: state.message);
      } else if (state is Authenticated) {
        return privateApp;
      } else {
        return redirect(context: context, message: 'something went wrong');
      }
    });
  }
}
