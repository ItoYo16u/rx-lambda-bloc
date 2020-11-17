import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Gradient _borderLinearGradient = LinearGradient(
  transform: GradientRotation(120),
  colors: [
    Colors.purpleAccent,
    Color(0xff7c4dff),
    Color(0xFF9575CD),
  ],
  tileMode: TileMode.clamp,
);

const Gradient _borderLinearGradientDisabled = LinearGradient(
  transform: GradientRotation(120),
  colors: [
    Color(0xFFD6D6D6),
    Color(0xFFD6D6D6),
  ],
  tileMode: TileMode.clamp,
);
enum _GradientButtonState { isDefault, isLoading, isDone }

class _GradientButtonViewModel extends ChangeNotifier {
  _GradientButtonState state = _GradientButtonState.isDefault;

  void updateState({@required _GradientButtonState newState}) {
    state = newState;
    notifyListeners();
  }
}

class GradientBorderButton extends StatelessWidget {
  GradientBorderButton(
      {@required this.child,
      @required this.onTap,
      this.strokeWidth = 1,
      this.isActive = true,
      this.borderRadius = 0,
      this.gradient = _borderLinearGradient})
      : _painter = _GradientPainter(
            gradient: gradient,
            strokeWidth: strokeWidth,
            borderRadius: borderRadius);

  GradientBorderButton.disabled(
      {@required this.child,
      @required this.onTap,
      this.strokeWidth = 1,
      this.borderRadius = 0,
      this.gradient = _borderLinearGradientDisabled})
      : isActive = false,
        _painter = _GradientPainter(
            gradient: gradient,
            strokeWidth: strokeWidth,
            borderRadius: borderRadius);

  final double strokeWidth;
  final Widget child;
  final bool isActive;
  final double borderRadius;
  final _GradientPainter _painter;
  final Gradient gradient;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: isActive ? 1 : 0.6,
        child: CustomPaint(
            painter: _painter,
            child: ChangeNotifierProvider(
                create: (_) => _GradientButtonViewModel(),
                builder: (_, __) => Consumer<_GradientButtonViewModel>(
                      builder: (_, model, __) => InkWell(
                        onTap: isActive && onTap != null
                            ? () async {
                                model.updateState(
                                    newState: _GradientButtonState.isLoading);
                                await onTap();
                                model.updateState(
                                    newState: _GradientButtonState.isDone);
                              }
                            : null,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 48 + strokeWidth,
                              vertical: 8 + strokeWidth),
                          child: model.state == _GradientButtonState.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : child,
                        ),
                      ),
                    ))),
      );
}

class _GradientPainter extends CustomPainter {
  _GradientPainter({this.gradient, this.strokeWidth, this.borderRadius = 0});

  final Gradient gradient;
  final double strokeWidth;
  final double borderRadius;
  final Paint _paint = Paint();

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    final innerRect = Rect.fromLTRB(strokeWidth, strokeWidth,
        size.width - strokeWidth, size.height - strokeWidth);
    final innerRoundedRect =
        RRect.fromRectAndRadius(innerRect, Radius.circular(borderRadius));

    final outerRect = Offset.zero & size;
    final outerRoundedRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(borderRadius));
    _paint.shader = gradient.createShader(outerRect);
    final borderPath = _calculateBorderPath(outerRoundedRect, innerRoundedRect);
    canvas.drawPath(borderPath, _paint);
  }

  Path _calculateBorderPath(RRect outerRRect, RRect innerRRect) {
    final outerRectPath = Path()..addRRect(outerRRect);
    final innerRectPath = Path()..addRRect(innerRRect);
    return Path.combine(PathOperation.difference, outerRectPath, innerRectPath);
  }
}
