import 'package:flutter/material.dart';

/// Inkwell の ripple effectを表示可能なリストタイル
class InkwellListTile extends StatelessWidget {
  const InkwellListTile({@required this.title, this.subtitle, this.onTap});

  final void Function() onTap;
  final Widget title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) => Material(
      key: GlobalKey(),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          title: title,
          subtitle: subtitle,
        ),
      ));
}
