import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordField extends StatelessWidget {
  PasswordField({
    @required this.controller,
    @required this.formKey,
    this.inputAction = TextInputAction.next,
    this.placeholder,
    this.onChanged,
    this.errorText,
  }) : viewModel = PasswordFieldViewModel(controller);
  final PasswordFieldViewModel viewModel;
  final TextEditingController controller;
  final Key formKey;
  final TextInputAction inputAction;
  final String placeholder;
  final String errorText;
  final void Function(String password) onChanged;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<PasswordFieldViewModel>.value(
        value: viewModel,
        child: Consumer<PasswordFieldViewModel>(
            builder: (_, viewModel, __) => Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: TextField(
                key: formKey,
                onChanged: onChanged,
                autofocus: false,
                autofillHints: const [AutofillHints.password],
                obscureText: viewModel.textHidden,
                controller: viewModel.controller,
                keyboardAppearance: Brightness.light,
                textInputAction: inputAction,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: placeholder ?? AppLocalizations.of(context).labelPassword,
                    errorText: errorText,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () => viewModel.toggleTextVisibility(),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8),
                              child: viewModel.textHidden
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            )),
                        GestureDetector(
                            onTap: () => viewModel.controller.clear(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.cancel),
                            )),
                      ],
                    )),
              ),
            )),
      );
}

class PasswordFieldViewModel extends ChangeNotifier {
  PasswordFieldViewModel(this.controller);

  final TextEditingController controller;
  bool textHidden = true;

  void toggleTextVisibility() {
    textHidden = textHidden == false;
    notifyListeners();
  }
  @override
  void dispose() {
    if(controller.hasListeners){
      controller.dispose();
    }
    super.dispose();
  }
}
