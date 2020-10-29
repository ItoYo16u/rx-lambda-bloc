import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_state.dart';
import 'package:functional_rx_bloc/view/bloc/auth/auth_bloc.dart';
import 'package:functional_rx_bloc/injection_container.dart' as di;

class Entry extends StatelessWidget {
  const Entry({Key key, this.builder, this.splashScreen}) : super(key: key);
  final Widget Function(BuildContext context) builder;
  final Widget splashScreen;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),

      // register Route here.
      // register theme here.
      // register localization here.
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: di.init(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MultiBlocProvider(
                providers: [
                  // register BloCs here.
                  // AuthBloc(UnAuthorized(),GetIt<usecase>())..init()
                  BlocProvider(create: (context) => AuthBloc(UnAuthorized())),
                  // BlocProvider(create: (ctx)=> ArticleBloc(Empty(),GetIt<usecase>())..add(Load()))
                  // articleBlocのstateにあるarticleはlike,dislike,scrappedに関する情報を持っている
                ],
                child: Builder(
                  builder: builder,
                ),
              );
            } else {
              // show splash screen.
              return splashScreen ??
                  const Center(
                    child: CircularProgressIndicator(),
                  );
            }
          },
        ),
      ),
    );
  }
}
