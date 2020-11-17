import 'package:flutter/material.dart';
/// グラデーションを書けたIonを表示するためのWidget
class GradientIcon extends Icon {
  const GradientIcon(IconData icon):super(icon);
  @override
  Widget build(BuildContext context) => ShaderMask(
    shaderCallback: (bounds) =>  LinearGradient(
      transform: const GradientRotation(120),
      colors: [
        Theme.of(context).accentColor,
        Theme.of(context).primaryColor,
      ],
      tileMode: TileMode.clamp,
    ).createShader(bounds),
    child: Icon(icon,color: Colors.white,),
  );
}