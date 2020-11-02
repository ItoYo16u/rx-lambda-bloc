import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_bloc.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_state.dart';
/// AuthWidget returns privateApp when authenticated, else redirects.
///
/// example AuthWidget(privateApp:MyApp(),redirect:({context,message})=>LoginScreen());
class AuthWidget extends StatelessWidget {
  const AuthWidget({@required this.privateApp, @required this.redirect});

  final Widget privateApp;

  /// [redirect] is widget displayed when user is not authenticated.
  final Widget Function(BuildContext context,{String message})
      redirect;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (before, after) => before != after,
        builder: (context, state) {
          if (state is NotAuthenticated) {
            return redirect(context, message: state.message);
          } else if (state is Authenticated) {
            return privateApp;
          } else if (state is TryInitializing) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return redirect(context, message: 'something went wrong');
          }
        });
  }
}
