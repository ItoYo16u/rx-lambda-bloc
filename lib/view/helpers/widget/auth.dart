import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_event.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_state.dart';
import 'package:functional_rx_bloc/view/bloc/auth/auth_bloc.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({@required this.privateApp, @required this.redirect});

  final Widget privateApp;
  final Widget Function({@required BuildContext context, String message})
      redirect;

  @override
  Widget build(BuildContext context) {
    // try auto login;
    Provider.of<AuthBloc>(context).add(SignInWithToken());
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is UnAuthorized) {
        return redirect(context: context, message: state.message);
      } else if (state is Pending) {
        return const Center(
          child: CircularProgressIndicator(),
        ); // show loading screen.
      } else if (state is Authorized) {
        return privateApp;
      } else if (state is Error) {
        return redirect(context: context, message: state.message);
      } else {
        return redirect(context: context, message: 'something went wrong');
      }
    });
  }
}
