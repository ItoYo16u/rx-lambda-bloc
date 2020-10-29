import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    @required this.controller,
    this.inputAction = TextInputAction.next,
    this.placeholder,
    this.onChanged,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.onEditingComplete,
  });

  final TextEditingController controller;
  final TextInputAction inputAction;
  final String placeholder;
  final String helperText;
  final String errorText;
  final void Function(String password) onChanged;
  final bool enabled;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail_outline),
          labelText: AppLocalizations.of(context).labelEmail,
          hintText: AppLocalizations.of(context).placeholderEmail,
          enabled: enabled,
          errorText: errorText,
          helperText: helperText,
          suffixIcon: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: controller.clear,
          )
      ),
      autocorrect: false,
      textInputAction: inputAction,
      keyboardType: TextInputType.emailAddress,
      keyboardAppearance: Brightness.light,
      onEditingComplete: onEditingComplete,
    );
  }
}