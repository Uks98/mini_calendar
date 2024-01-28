import 'dart:html';

import 'package:camera/camera.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class CalendarMlPage extends StatefulWidget {
  const CalendarMlPage({super.key});

  @override
  State<CalendarMlPage> createState() => _CalendarMlPageState();
}
File? _image;
final bool _canProcess = true;
bool _isBusy = false;
CustomPaint? _customPaint;
final _cameraLensDirection = CameraLensDirection.back;

var script = TextRecognitionScript.korean;

TextRecognizer textRecognizer =
TextRecognizer(script: TextRecognitionScript.korean);

final ImagePicker _imagePicker = ImagePicker();

class _CalendarMlPageState extends State<CalendarMlPage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [
          IconButton(
            tooltip: "사진 속 글자를 메모장에 작성해줄게요.",
            onPressed: (){
              //_getImage(ImageSource.gallery);
            },
            icon: Icon(
              EvaIcons.bookOpenOutline,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Future _processFile(String path) async {
    setState(() {
      _image = File(path);
    });
    final inputImage = InputImage.fromFilePath(path);
    _processImage(inputImage);
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _textEditingController.text = "";
    });
    final recognizedText = await textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
    } else {
      _textEditingController.text = "${recognizedText.text}\n";
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
