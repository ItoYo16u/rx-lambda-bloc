import 'package:flutter/material.dart';

const Gradient _linearGradient = LinearGradient(
  transform: GradientRotation(120),
  colors: [
    Colors.purpleAccent,
    Color(0xff7c4dff),
    Color(0xFF9575CD),
  ],
  tileMode: TileMode.clamp,
);

class GradientText extends StatelessWidget {
  const GradientText(this.text,
      {this.style,
        this.align = TextAlign.left,
        this.gradient = _linearGradient});

  final TextStyle style;
  final String text;
  final Gradient gradient;
  final TextAlign align;

  @override
  Widget build(context) => ShaderMask(
    shaderCallback: (bounds) => gradient.createShader(
      Rect.fromLTRB(0, 0, bounds.width, bounds.height),
    ),
    child: Text(
      text,
      style: style?.copyWith(color: Colors.white) ??
          Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
      textAlign: align,
    ),
  );
}
