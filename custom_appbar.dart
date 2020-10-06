import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String text;

  CustomAppBar({
    this.backgroundColor = Colors.black,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final child2 = Positioned(
      right: 20,
      left: 20,
      bottom: -25,
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Icon(Icons.search),
            ),
            Expanded(
              flex: 5,
              child: TextField(
                decoration:
                    InputDecoration.collapsed(hintText: "Search here..."),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                offset: Offset(0, 5),
                spreadRadius: 1,
                blurRadius: 1,
              )
            ]),
      ),
    );
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          willChange: false,
          size: Size.fromHeight(150),
          painter: _AppBarBackgroundPainter(
            backgroundColor: backgroundColor,
          ),
          child: Center(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print("Notification");
                  },
                )
              ],
            ),
          ),
        ),
        child2
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(150.0);
}

class _AppBarBackgroundPainter extends CustomPainter {
  final Color backgroundColor;
  _AppBarBackgroundPainter({@required this.backgroundColor});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );
    canvas.drawCircle(
      Offset(size.width / 2, 0),
      size.width / 4,
      Paint()..color = Colors.white12,
    );
    canvas.drawCircle(
      Offset(size.width / 1.2, 20),
      size.width / 4,
      Paint()..color = Colors.white12,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
