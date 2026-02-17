import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> bitmapDescriptorFromIconData(
    IconData iconData, Color color, double size) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);

  final iconStr = String.fromCharCode(iconData.codePoint);
  
  textPainter.text = TextSpan(
      text: iconStr,
      style: TextStyle(
        letterSpacing: 0.0,
        fontSize: size,
        fontFamily: iconData.fontFamily,
        color: color,
      ));
  textPainter.layout();
  textPainter.paint(canvas, const Offset(0.0, 0.0));

  final a = await pictureRecorder.endRecording().toImage(
        textPainter.width.toInt(),
        textPainter.height.toInt(),
      );
  final b = await a.toByteData(format: ui.ImageByteFormat.png);
  final c = b!.buffer.asUint8List();

  return BitmapDescriptor.fromBytes(c);
}
