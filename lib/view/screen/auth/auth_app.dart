import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/interface/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_state.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_bloc.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_event.dart';
import 'package:functional_rx_bloc/injection_container.dart' as di;
import 'package:functional_rx_bloc/view/screen/auth/bloc/try_auth_bloc.dart';
import 'package:provider/provider.dart';

// NOTE: auth screen builderをmaterial appにして、navigatorの範囲をその内部で制限すればいいかも.
// auth screen builder(initialRoute:AuthPage.signIn)みたいに.
class AuthApp extends StatelessWidget {
  const AuthApp({@required this.builder});

  final Widget Function(BuildContext, {String message}) builder;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
            body: BlocProvider(
                create: (context) =>
                    TryAuthBloc(
                        Ready(), middleware: di.sl.get<AuthMiddleware>()),
                child: Builder(
                  builder: (context) =>
                      BlocListener<TryAuthBloc, TryAuthState>(
                        listenWhen: (prev, next) => prev != next,
                        listener: (context, state) {
                          if (state is Error) {
                            Scaffold.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                  SnackBar(content: Text(state.message)));
                          } else if (state is Success) {
                            Provider.of<AuthBloc>(context, listen: false)
                                .add(UpdateToBeAuthenticated(state.token));
                          }
                        },
                        child: BlocBuilder<TryAuthBloc, TryAuthState>(
                            builder: (context, state) {
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
                      ),
                )),
        )
    );
  }
}
