import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_event.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_state.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_authentication_event.dart';
import 'package:functional_rx_bloc/view/bloc/auth/auth_bloc.dart';
import 'package:functional_rx_bloc/view/bloc/auth/try_auth_bloc.dart';
import 'package:provider/provider.dart';

class AuthScreenBuilder extends StatelessWidget {
  const AuthScreenBuilder({@required this.builder});

  final Widget Function(BuildContext, {String message}) builder;

  @override
  Widget build(BuildContext context) {
    Provider.of<TryAuthBloc>(context, listen: false).add(SignInWithToken());
    // try auto login;
    return BlocListener<TryAuthBloc, TryAuthState>(
      listenWhen: (prev, next) => prev != next,
      listener: (context, state) {
        if (state is Error) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is Success) {
          Provider.of<AuthBloc>(context, listen: false)
              .add(const UpdateToBeAuthenticated());
        }
      },
      child: BlocBuilder<TryAuthBloc, TryAuthState>(builder: (context, state) {
        if (state is Ready) {
          return builder(context, message: state.message);
        } else if (state is Pending || state is Success) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Error) {
          return builder(context);
        } else {
          return builder(context);
        }
      }),
    );
  }
}
