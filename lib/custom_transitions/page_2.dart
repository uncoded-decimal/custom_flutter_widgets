import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math' as Math;

class Page2 extends StatefulWidget {
  final Animation<double> animation;
  const Page2({
    Key? key,
    required this.animation,
  }) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    widget.animation
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.forward();
        }
      });
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          })
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Page2Painter(widget.animation.value, _controller.value),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          heightFactor: 1.2,
          child: Image.network(
            "https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/Starbucks_Corporation_Logo_2011.svg/1200px-Starbucks_Corporation_Logo_2011.svg.png",
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Page2Painter extends CustomPainter {
  double value;
  double secondValue;

  Page2Painter(this.value, this.secondValue);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.brown.shade600);
    Path _backgroundShape = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height * value)
      ..lineTo(size.width, size.height * value)
      ..close();
    canvas.drawPath(
        _backgroundShape,
        Paint()
          ..shader = ui.Gradient.linear(
            Offset(0, 0),
            Offset(0, size.height * value),
            [
              Color(0xffAB6C40),
              Colors.brown.shade600,
            ],
          ));

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

    canvas.drawPath(
      _path,
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(0, size.height * (1 - value)),
          Offset(0, size.height),
          [
            Color(0xff80422D),
            Color(0xff763319),
            // Colors.brown.shade900,
            // Colors.brown.shade800,
            // Colors.brown.shade600,
          ],
          [
            // 0.05,
            0.1,
            0.2,
            // 0.98,
          ],
        ),
    );

    /// another lyer

    Path _path2 = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height - (size.height * value) + 180);

    double amplitude2 = size.height - (size.height * value) + 180;
    for (double t = 0.0; t <= size.width; t = t + 0.5) {
      double y = amplitude2 *
          (1.0 +
              Math.sin((2 +
                          2 *
                              (value == 1 ? value + secondValue : value) *
                              (value == 1 ? value + secondValue : value)) *
                      Math.pi *
                      (t + (value == 1 ? value + secondValue : value)) /
                      size.width) /
                  20);
      _path2.lineTo(t, y);
      // print("$t,$y");
    }
    _path2.close();

    canvas.drawPath(
      _path2,
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(0, size.height * (1 - value)),
          Offset(0, size.height),
          [
            Color(0xffBB9976),
            // Colors.brown.shade800,
            // Colors.brown.shade600,
            // Colors.brown.shade600,
            Color(0xff936A4E),
          ],
          // [
          //   0.1,
          //   0.6,
          //   0.9,
          //   0.98,
          // ],
        ),
    );
  }

  @override
  bool shouldRepaint(Page2Painter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(Page2Painter oldDelegate) => false;
}
