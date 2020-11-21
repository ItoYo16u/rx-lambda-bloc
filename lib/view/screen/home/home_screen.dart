import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/view/components/animation/fade_in.dart';
import 'package:functional_rx_bloc/view/components/partial/form/smart_address_form.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_bloc.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_event.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmartAddressForm(),
          RaisedButton(
              child: Text(
                AppLocalizations.of(context).labelSignOut,
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () => Provider.of<AuthBloc>(context, listen: false)
                  .add(const UpdateToBeUnAuthenticated())),
        ],

      ),
  bottomNavigationBar: BottomNavigationBar(
      items:const  [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.star_rounded),label: 'favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined),label: 'like'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: 'cart'),
        BottomNavigationBarItem(icon: Icon(Icons.credit_card),label: 'card'),
      ],
  ),
  );
}
