import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/view/helpers/constants/route_path.dart';
import 'package:functional_rx_bloc/view/screen/auth/screen/sign_in_screen.dart';
import 'package:functional_rx_bloc/view/screen/auth/screen/sign_up_screen.dart';

class AuthRoute {
  static Map<String, WidgetBuilder> routes = {
    RoutePath.signIn: (_) => SignInScreen(),
    RoutePath.signUp: (_) => SignUpScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.signUp:
        return PageRouteBuilder<SignUpScreen>(
            pageBuilder: (context, _, __) => SignUpScreen(),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            });
      case RoutePath.signIn:
        return PageRouteBuilder<SignInScreen>(
            pageBuilder: (context, _, __) => SignInScreen(),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            });
      default:
        return PageRouteBuilder<SignInScreen>(
            pageBuilder: (context, _, __) => SignInScreen(),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            });
    }
  }
}
