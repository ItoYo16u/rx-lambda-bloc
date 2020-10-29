import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_event.dart';
import 'package:functional_rx_bloc/view/bloc/auth/auth_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
              child: Text(AppLocalizations.of(context).labelSignOut),
              onPressed: () =>
                  Provider.of<AuthBloc>(context, listen: false).add(SignOut())),
        ],
      ));
}