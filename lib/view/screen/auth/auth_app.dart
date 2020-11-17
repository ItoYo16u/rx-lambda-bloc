import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/interface/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_state.dart';
import 'package:functional_rx_bloc/injection_container.dart' as di;
import 'package:functional_rx_bloc/view/helpers/constants/route_path.dart';
import 'package:functional_rx_bloc/view/screen/auth/bloc/try_auth_bloc.dart';
import 'package:functional_rx_bloc/view/screen/auth/route/auth_route.dart';

// NOTE: auth screen builderをmaterial appにして、navigatorの範囲をその内部で制限すればいいかも.
// auth screen builder(initialRoute:AuthPage.signIn)みたいに.
class AuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            TryAuthBloc(Ready(), middleware: di.sl.get<AuthMiddleware>()),
        child: const MaterialApp(
          // 初回起動時はroutePath.signUpを、初回起動でないなら、signInをinitialRouteにする、
          initialRoute: RoutePath.signIn,
          onGenerateRoute: AuthRoute.generateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ));
  }
}
