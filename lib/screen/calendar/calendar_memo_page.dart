
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';

class MemoPage extends StatefulWidget {
  Schedule memoText;

  MemoPage({super.key, required this.memoText,});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  File? _image;
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  final _cameraLensDirection = CameraLensDirection.back;

  var script = TextRecognitionScript.korean;

  TextRecognizer textRecognizer =
  TextRecognizer(script: TextRecognitionScript.korean);

  ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController(text: widget.memoText.memo.toString());
   // _textEditingController.text = widget.memoText.memo.toString();
  //  _textEditingController.text = widget.memoText.memo;
  }

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: "사진 속 글자를 메모장에 작성해줄게요.",
            onPressed: () => _getImage(ImageSource.gallery),
            icon: Icon(
              Icons.text_snippet_outlined,
              color: Colors.grey[600],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(Schedule(
                id: DateTime.now().microsecondsSinceEpoch,
                memo: _textEditingController.text,
                colorIndex: 0,
                isShowMap: true,
              ));
            },
            child: "완료".text.fontWeight(FontWeight.w300).make(),
          )
        ],
        centerTitle: true,
        title: "메모".text.fontWeight(FontWeight.w300).make(),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(

              maxLines: 20,
              cursorColor: Colors.black,
              controller: _textEditingController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                // hintText: '텍스트를 입력하세요',
              ),
              style: TextStyle(fontSize: normalFontSize,fontWeight: FontWeight.w300),
            ).paddingAll(bigHeight),
          )
          //Expanded(child: TextField())
        ],
      ),
    );
  }
  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
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
      print(recognizedText.text);
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
