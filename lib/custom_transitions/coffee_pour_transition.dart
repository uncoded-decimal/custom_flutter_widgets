import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as Math;

class CoffeePourAnimation extends AnimatedWidget {
  final Animation<double> propertyValue;
  final Widget child;

  CoffeePourAnimation(this.propertyValue, this.child)
      : super(listenable: propertyValue);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: child,
      clipper: PathClipper(propertyValue.value),
    );
  }
}

class PathClipper extends CustomClipper<Path> {
  final double value;

  PathClipper(this.value);

  @override
  Path getClip(Size size) {
    Path _path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height - (size.height * value));

    double amplitude = size.height - (size.height * value);
    for (double t = 0.0; t <= size.width; t = t + 0.5) {
      double y = amplitude *
          (1.0 +
              Math.sin((2 + 2 * value * value) *
                      Math.pi *
                      (t + value) /
                      size.width) /
                  20);
      _path.lineTo(t, y);
      // print("$t,$y");
    }
    _path.close();

    Path _pourPath = Path()
      ..moveTo(size.width * (1.5 - Math.sin(value * Math.pi)), 0)
      ..lineTo(
          size.width * (1.5 - Math.sin(value * Math.pi)) +
              20 +
              10 * Math.sin(value * Math.pi),
          0)
      ..arcToPoint(
        Offset(
            size.width * (1.5 - Math.sin(value * Math.pi)) +
                20 +
                10 * Math.sin(value * Math.pi),
            size.height),
        clockwise: false,
        radius: Radius.circular(size.height * (4 + 3 * value)),
      )
      ..lineTo(size.width * (1.5 - Math.sin(value * Math.pi)), size.height)
      ..close();
    _path.addPath(_pourPath, Offset(0, 0));

    return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
