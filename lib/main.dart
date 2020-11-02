import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_widget.dart';
import 'package:functional_rx_bloc/view/helpers/widget/entry.dart';
import 'package:functional_rx_bloc/view/screen/auth/auth_screen.dart';
import 'package:functional_rx_bloc/view/screen/auth/auth_app.dart';
import 'package:functional_rx_bloc/view/screen/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Entry(
      builder: (_) => AuthWidget(
          privateApp: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: HomeScreen(),
            ),
          ),
          // redirect: => AuthScreen
          redirect: (context, {message}) => AuthApp(
              builder: (context, {String message}) => AuthScreen(
                    message: message,
                  ))),
    );
  }
}
