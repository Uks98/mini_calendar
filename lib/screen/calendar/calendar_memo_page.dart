import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';

class MemoPage extends StatefulWidget {
  Schedule memoText;
  MemoPage({super.key,required this.memoText});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  String get ctx => _controller.plainTextEditingValue.text;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){

            Navigator.of(context).pop(Schedule(
              id: DateTime.now().microsecondsSinceEpoch,
              title: '',
              memo: _controller.plainTextEditingValue.text.toString(),
              from: DateTime.now(),
              to: DateTime.now(),
              myPlace: '',
              gpsX: 0.0,
              gpsY: 0.0,
              colorIndex: 0,
              isShowMap: false,
            ));
          },
          child: "저장".text.make(),
        ),
        body: Column(
          children: [
            QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                showSearchButton: false,
                showFontFamily : false,
                showStrikeThrough: false,
                showSubscript : false,
                showSuperscript: false,
                showSmallButton : false,
                showClearFormat: false,
                showCodeBlock: false,
                showHeaderStyle: false,
                showIndent: false,
                showLeftAlignment: false,
                showListCheck: false,
                showFontSize: false,
                showListBullets: false,
                showInlineCode: false,
                showColorButton: false,
                showLink: false,
                controller: _controller,
                sharedConfigurations: const QuillSharedConfigurations(
                  locale: Locale('de'),
                ),
              ),
            ),
            Expanded(
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  autoFocus: true,
                  controller: _controller,
                  readOnly: false,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('de'),
                  ),
                ),
              ),
            )
            //Expanded(child: TextField())
          ],
        ),
      ),
    );
  }
}
