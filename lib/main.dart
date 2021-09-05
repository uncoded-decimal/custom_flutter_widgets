import 'package:custom_widgets/custom_transitions/coffee_pour_transition.dart';
import 'package:custom_widgets/custom_transitions/page_2.dart';
import 'package:custom_widgets/custom_widgets/8bit_animated_input_border.dart';
import 'package:flutter/material.dart';

import 'custom_widgets/custom_input_border.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _8BitController;
  late Animation<int> _8BitTween;

  @override
  void initState() {
    super.initState();
    _8BitController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 3,
      ),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // print("AimationStatus completed");
          _8BitController.forward(from: 0);
        } else if (status == AnimationStatus.dismissed) {
          // print("AimationStatus dismissed");
          _8BitController.forward(from: 0);
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _8BitController.forward();
    _8BitTween = IntTween(
      begin: 0,
      end: 6,
    ).animate(_8BitController);
  }

  @override
  void dispose() {
    _8BitController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    Navigator.push(
        context,
        PageRouteBuilder(
          barrierColor: Colors.black45,
          barrierDismissible: true,
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) =>
              Page2(animation: animation),
          transitionDuration: Duration(seconds: 7),
          reverseTransitionDuration: Duration(seconds: 2),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              CoffeePourAnimation(
            animation,
            child,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (s) {
                    if (s != null) {
                      if (!s.contains('a')) {
                        return "Why no 'a'?";
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Homeowner's name",
                    border: CustomInputBorder(),
                    focusedBorder: CustomInputBorder(
                      borderColor: Colors.blue,
                      width: 4,
                    ),
                    errorBorder: CustomInputBorder(
                      borderColor: Colors.red,
                    ),
                    focusedErrorBorder: CustomInputBorder(
                      borderColor: Colors.red,
                    ),
                  )),
            ),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (s) {
                    if (s != null) {
                      if (s.contains('lollipop')) {
                        return "We don't have 'lollipop'? :,(";
                      }
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pixeboy',
                    fontSize: 25.0,
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pixeboy',
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Pixeboy',
                    ),
                    labelText: "What flavour?",
                    border: EightBitAnimatedInputBorder(
                      state: _8BitTween.value,
                    ),
                    focusedBorder: EightBitAnimatedInputBorder(
                      state: _8BitTween.value,
                    ),
                    errorBorder: EightBitAnimatedInputBorder(
                      state: _8BitTween.value,
                      borderColor: Colors.red,
                    ),
                    focusedErrorBorder: EightBitAnimatedInputBorder(
                      state: _8BitTween.value,
                      borderColor: Colors.redAccent,
                    ),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
