import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    @required this.child,
    this.title = '',
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Text(
                title,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              child: child,
            )
          ],
        ),
      );
}
