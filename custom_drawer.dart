import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final double width;
  final Widget drawerHeader;
  final Widget footer;
  final List<Widget> options;
  CustomDrawer({
    Key key,
    @required this.width,
    this.drawerHeader,
    this.footer,
    this.options,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(),
      child: Material(
        type: MaterialType.canvas,
        child: CustomPaint(
          size: Size.fromWidth(widget.width),
          painter: _DrawerPainter(),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: widget.drawerHeader ??
                    Container(
                      height: 0,
                    ),
              ),
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount: widget.options?.length ?? 6,
                  itemBuilder: (context, index) =>
                      widget.options?.elementAt(index) ??
                      ListTile(
                        title: Text("Item $index"),
                      ),
                ),
              ),
              Flexible(
                child: widget.footer ?? Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Color(0xff1B910F));
    canvas.drawCircle(Offset(size.width / 1.1, size.height * 1.1),
        size.width * 0.7, Paint()..color = Color(0xff24A718));
    canvas.drawCircle(Offset(0, size.height * 1.2), size.width * 0.7,
        Paint()..color = Color(0xff2DBB1F));
    canvas.drawCircle(Offset(size.width / 1.2, size.height * 1.2),
        size.width * 0.7, Paint()..color = Color(0xff40C932));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
