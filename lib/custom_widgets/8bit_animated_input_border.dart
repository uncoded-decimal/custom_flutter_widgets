import 'package:flutter/material.dart';

class EightBitAnimatedInputBorder extends InputBorder {
  final double borderWidth;
  final double tabLength;
  final int state;
  final Color borderColor;

  EightBitAnimatedInputBorder({
    this.borderWidth = 3.0,
    this.tabLength = 10.0,
    this.borderColor = Colors.white,
    required this.state,
  });

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return this;
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(RRect.fromRectXY(rect, 0, 0));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(RRect.fromRectXY(rect, 0, 0));
  }

  @override
  bool get isOutline => true;

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    for (Offset start = rect.bottomLeft;
        start.dx < rect.bottomRight.dx;
        start = start + Offset(tabLength, 0)) {
      int tabIndex = ((start - rect.bottomLeft).dx / tabLength).round();
      // print(tabIndex);
      double value = tabIndex % 6;
      if (value > 3) value = value - 3;
      // print("$state - $value");
      double y = (state + value) % 4;
      // print(y);
      canvas.drawLine(
        start.translate(0, y),
        start.translate(tabLength, y),
        Paint()
          ..color = borderColor
          ..strokeWidth = borderWidth,
      );
    }
  }

  @override
  ShapeBorder scale(double t) {
    return EightBitAnimatedInputBorder(
      state: state,
      borderWidth: borderWidth * t,
    );
  }
}
