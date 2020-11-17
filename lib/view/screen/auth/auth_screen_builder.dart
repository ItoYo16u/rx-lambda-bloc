import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_state.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_authentication_event.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_bloc.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_event.dart';
import 'package:functional_rx_bloc/view/screen/auth/bloc/try_auth_bloc.dart';
import 'package:provider/provider.dart';

class AuthScreenBuilder extends StatelessWidget {
  const AuthScreenBuilder({@required this.builder,this.title});

  final Widget Function(BuildContext) builder;
  final String title;

  @override
  Widget build(BuildContext context) {
    Provider.of<TryAuthBloc>(context,listen: false).add(Retry());
    return Scaffold(
        body: Builder(
      builder: (context) => BlocListener<TryAuthBloc, TryAuthState>(
        listenWhen: (prev, next) => prev != next,
        listener: (context, state) {
          if (state is Error) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)))
                  .closed
                  .then((value) =>
                      Provider.of<TryAuthBloc>(context,listen: false).add(Retry()));
          } else if (state is Success) {
            Provider.of<AuthBloc>(context, listen: false)
                .add(UpdateToBeAuthenticated(state.user));
          } else if (state is Ready) {
            Scaffold.of(context).hideCurrentSnackBar();
          }
        },
        child: BlocBuilder<TryAuthBloc, TryAuthState>(
            buildWhen: (prev, next) => prev != next,
            builder: (context, state) {
              if (state is Ready) {
                return builder(context);
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
      ),
    ));
  }
}
