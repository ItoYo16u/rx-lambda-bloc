import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/view/helpers/constants/layout_helper.dart';

class Flip extends StatefulWidget {
  const Flip({@required this.front, @required this.back});

  final Widget front;
  final Widget back;

  @override
  _FlipState createState() => _FlipState();
}

class _FlipState extends State<Flip> with SingleTickerProviderStateMixin {
  AnimationController controller;
  bool isFront = true;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400))
      ..addListener(() {
        if (controller.value > 0.5 && isFront == true) {
          setState(() {
            isFront = false;
          });
        } else if (controller.value <= 0.5 && isFront == false) {
          setState(() {
            isFront = true;
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () {
        if (controller.status == AnimationStatus.completed) {
          controller.reverse();
        } else {
          controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, child) => Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(math.pi * controller.value),
          child: child,
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(
              horizontal: LayoutHelper.commonHorizontalPadding,
              vertical: LayoutHelper.commonVerticalPadding),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(LayoutHelper.commonBorderRadius),
            color: Theme.of(context).primaryColor,
          ),
          child: isFront
              ? widget.front
              : Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateY(math.pi),
                  child: widget.back,
                ),
        ),
      ));
}
