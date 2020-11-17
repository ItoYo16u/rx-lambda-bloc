import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/view/helpers/constants/layout_helper.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({this.iconData = Icons.add, this.callback});

  final IconData iconData;
  final void Function() callback;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: callback,
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 180,
      padding: const EdgeInsets.symmetric(
          vertical: LayoutHelper.commonVerticalPadding,
          horizontal: LayoutHelper.commonHorizontalPadding),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(LayoutHelper.commonBorderRadius),
      ),
      child: Center(
        child: Icon(iconData),
        ),
      ),
    );
}
