import 'package:flutter/cupertino.dart';

/// 小さな画面でキーボードが表示されたときにlayout errorが出ないようにフォームをラップするためのウィジェット.
class FormWrapper extends StatelessWidget {
  const FormWrapper({this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children),
            ));
  }
}
