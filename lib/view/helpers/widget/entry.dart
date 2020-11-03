import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/injection_container.dart' as di;
import 'package:functional_rx_bloc/modules/middleware/auth/interface/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/initialize/initialize_middleware.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_bloc.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_event.dart';
import 'package:provider/provider.dart';

class Entry extends StatefulWidget {
  const Entry({this.builder, this.splashScreen}) : super();
  final Widget Function(BuildContext context) builder;

  ///NOTE splash screen must have Scaffold.
  final Widget splashScreen;

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  Future<bool> _init;

  @override
  void initState() {
    super.initState();

    /// 認証状態に依存しない初期化処理.
    _init = di.init().then((b) async {
      final sl = di.sl;
      final restoredUserEither = await sl.get<AuthMiddleware>().tryAutoSignIn();
      /// theme,preferences,isUpdateRequired,isFirstVisit?,
      final restoredSettingsEither = await sl.get<GeneralConfigMiddleware>().init();
      const restoredState = 'RestoredState(restoredUserEither,restoredSettingsEither)';
      return Future<bool>.delayed(const Duration(seconds: 1)).then((__) => b);
    });
    /*もし時間のかかる初期化のmiddlewareがあるなかここでdi.sl.initMiddleware.init()を呼び出す*/
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
      home: FutureBuilder<bool>(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                BlocProvider(
                    create: (context) => AuthBloc()
                      ..add(TryInitializeWithMiddleware(
                          middleware: di.sl.get()))),
              ],
              child: Builder(
                builder: widget.builder,
              ),
            );
          } else {
            // show splash screen.
            return widget.splashScreen ??
                const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          }
        },
      ),
    );
  }
}
