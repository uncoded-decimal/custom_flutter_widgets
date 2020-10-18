import 'dart:io';

import 'package:image/image.dart' as img;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:medovy/utility/app_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// This uses the plugins [camera], [path] and [path_provider]
class CardScanner extends StatefulWidget {
  CardScanner({Key key}) : super(key: key);

  @override
  _CardScannerState createState() => _CardScannerState();
}

class _CardScannerState extends State<CardScanner> {
  bool _isCameraReady = false;
  CameraDescription _cameraSelected;
  CameraController _cameraController;

  Offset firstCorner;
  Offset secondCorner;
  Offset thirdCorner;
  Offset fourthCorner;

  @override
  void initState() {
    super.initState();
    _ensureCameraInitialized();
  }

  void _ensureCameraInitialized() async {
    final cameras = await availableCameras();
    _cameraSelected = cameras.first;
    _cameraController =
        CameraController(_cameraSelected, ResolutionPreset.veryHigh);
    _cameraController.initialize().then((value) => setState(() {
          _isCameraReady = true;
        }));
  }

  void _calculateBounds() {
    Size size = MediaQuery.of(this.context).size;
    final boxPadding = ((size.width - insuranceCardWidth) / 2).abs();
    firstCorner =
        Offset(boxPadding, (size.height / 2) - (insuranceCardHeight / 2));
    secondCorner = Offset(
        size.width - boxPadding, (size.height / 2) - (insuranceCardHeight / 2));
    thirdCorner = Offset(
        size.width - boxPadding, (size.height / 2) + (insuranceCardHeight / 2));
    fourthCorner =
        Offset(boxPadding, (size.height / 2) + (insuranceCardHeight / 2));
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraReady)
      return Container(
        child: CircularProgressIndicator(),
        alignment: Alignment.center,
        color: Colors.white,
      );

    _calculateBounds();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            child: CameraPreview(_cameraController),
            foregroundPainter: ScannerPainter(firstCorner, thirdCorner),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              color: Colors.black,
              // alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: 60,
                      ),
                      onPressed: () async {
                        try {
                          final path = join(
                            // Store the picture in the temp directory.
                            // Find the temp directory using the `path_provider` plugin.
                            (await getTemporaryDirectory()).path,
                            '${DateTime.now().millisecondsSinceEpoch}.png',
                          );
                          await _cameraController.takePicture(path);

                          ///The code below is to crop the image to required
                          ///coordinates without having to draw it on an
                          ///onscreen canvas

                          final card =
                              img.decodeImage(File(path).readAsBytesSync());

                          final img.Image croppedCard = img.copyCrop(
                            card,
                            firstCorner.dx.floor(),
                            firstCorner.dy.floor(),
                            insuranceCardWidth.ceil(),
                            insuranceCardHeight.ceil(),
                          );
                          String newPath = join(
                              (await getTemporaryDirectory()).path,
                              "${DateTime.now().millisecondsSinceEpoch}.png");
                          final newFile = File(newPath);
                          newFile.writeAsBytesSync(img.encodePng(croppedCard));
                          Navigator.pop(context, newPath);
                        } catch (e) {
                          print("CameraException $e");
                        }
                      }),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context)),
          ),
          Positioned(
            top: 130,
            left: 10,
            right: 10,
            child: Text(
              "Hold your card inside the frame",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}

class ScannerPainter extends CustomPainter {
  final Offset firstCorner;
  final Offset thirdCorner;

  ScannerPainter(this.firstCorner, this.thirdCorner);

  @override
  void paint(Canvas canvas, Size size) {
    final box = Rect.fromPoints(firstCorner, thirdCorner);
    final roundedBox = RRect.fromRectAndCorners(
      box,
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    );
    canvas.drawPath(
      Path.combine(
          PathOperation.difference,
          Path()
            ..addRect(
                Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height))),
          Path()..addRRect(roundedBox)),
      Paint()..color = Colors.black.withAlpha(200),
    );
    canvas.drawRRect(
      roundedBox,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
