import 'package:flutter/material.dart';

class CustomInputBorder extends InputBorder {
  final double width;
  final Color borderColor;

  CustomInputBorder({
    this.width = 3.0,
    this.borderColor = Colors.black,
  });

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return this;
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

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
    double distanceFromTopLeft = 20;
    double heightOverLabel = 3;
    canvas.drawLine(
      rect.topLeft +
          Offset(
            2 * distanceFromTopLeft +
                15 +
                (gapExtent - distanceFromTopLeft) * gapPercentage,
            0,
          ),
      rect.topRight - Offset(distanceFromTopLeft, 0),
      Paint()
        ..color = borderColor
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.drawLine(
      rect.topRight -
          Offset(
            distanceFromTopLeft,
            0,
          ),
      rect.topRight + Offset(0, 15),
      Paint()
        ..color = borderColor
        ..strokeWidth = width,
    );
    canvas.drawLine(
      rect.topRight,
      rect.bottomRight,
      Paint()
        ..strokeWidth = width
        ..color = Colors.transparent,
    );
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomLeft,
      Paint()
        ..strokeWidth = width
        ..color = Colors.transparent,
    );
    canvas.drawLine(
      rect.bottomLeft,
      rect.topLeft,
      Paint()
        ..color = borderColor
        ..strokeWidth = width,
    );
    canvas.drawLine(
      rect.topLeft - Offset(10, 0),
      rect.topLeft + Offset(distanceFromTopLeft, -15 - heightOverLabel),
      Paint()
        ..color = borderColor
        ..strokeWidth = width,
    );
    canvas.drawLine(
      rect.topLeft + Offset(distanceFromTopLeft, -15 - heightOverLabel),
      rect.topLeft +
          Offset(
              distanceFromTopLeft + distanceFromTopLeft + 10, -heightOverLabel),
      Paint()
        ..color = borderColor
        ..strokeWidth = width,
    );
  }

  @override
  ShapeBorder scale(double t) {
    return CustomInputBorder(
      width: width * t,
    );
  }
}
