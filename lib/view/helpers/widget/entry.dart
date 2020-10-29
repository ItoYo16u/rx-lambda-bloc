import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/interface/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_event.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_state.dart';
import 'package:functional_rx_bloc/view/bloc/auth/auth_bloc.dart';
import 'package:functional_rx_bloc/injection_container.dart' as di;

class Entry extends StatefulWidget {
  const Entry({this.builder, this.splashScreen}) : super();
  final Widget Function(BuildContext context) builder;
  final Widget splashScreen;

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  Future<bool> _init;

  @override
  void initState() {
    super.initState();
    _init = di.init().then((_) => _/*もし時間のかかる初期化のmiddlewareがあるなかここでdi.sl.initMiddleware.init()を呼び出す*/);
  }

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
          future: _init,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MultiBlocProvider(
                providers: [
                  // register BloCs here.
                  BlocProvider(
                      create: (context) => AuthBloc(UnAuthorized(),
                          middleware: di.sl.get<AuthMiddleware>())
                        ..add(SignInWithToken())),
                  // BlocProvider(create: (ctx)=> ArticleBloc(Empty(),GetIt<usecase>())..add(Load()))
                  // articleBlocのstateにあるarticleはlike,dislike,scrappedに関する情報を持っている
                ],
                child: Builder(
                  builder: widget.builder,
                ),
              );
            } else {
              // show splash screen.
              return widget.splashScreen ??
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
