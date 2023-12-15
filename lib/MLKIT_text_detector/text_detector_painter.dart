import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognizerPainter extends CustomPainter {
  TextRecognizerPainter(
    this.recognizedText,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final RecognizedText recognizedText;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.red;

    final Paint background = Paint()..color = Colors.black;
    
  }

  @override
  bool shouldRepaint(TextRecognizerPainter oldDelegate) {
    return oldDelegate.recognizedText != recognizedText;
  }
}
