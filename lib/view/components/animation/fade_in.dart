import 'package:flutter/cupertino.dart';

enum SlideInDirection { x, y }

class FadeIn extends StatelessWidget {
  const FadeIn(
      {@required this.child,
      this.delay = 0,
      this.direction = SlideInDirection.x});

  final Widget child;
  final double delay;
  final SlideInDirection direction;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        child: child,
        curve: Interval(delay, 1, curve: Curves.easeInOut),
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 1600),
        builder: (BuildContext context, double d, child) => Transform.translate(
              offset: direction == SlideInDirection.x
                  ? _mapOffsetX(d)
                  : _mapOffsetY(d),
              child: Opacity(
                opacity: d,
                child: child,
              ),
            ));
  }

  Offset _mapOffsetY(double d) => Offset(0, -40 * d + 40);

  Offset _mapOffsetX(double d) => Offset(-100 + 100 * d, 0);
}
