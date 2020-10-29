import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth.dart';
import 'package:functional_rx_bloc/view/helpers/widget/entry.dart';
import 'package:functional_rx_bloc/view/screen/auth/auth_screen.dart';
import 'package:functional_rx_bloc/view/screen/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Entry(
      builder: (context) => AuthWidget(
          privateApp: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: HomeScreen(),
            ),
          ),
          // redirect: => AuthScreen
          redirect: ({context, message}) => AuthScreen(message: message,)),
    );
  }
}
