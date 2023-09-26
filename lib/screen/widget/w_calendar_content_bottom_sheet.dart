import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:after_layout/after_layout.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/dart/extension/datetime_extension.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/widget/w_rounded_container.dart';
import 'package:today_my_calendar/screen/widget/w_show_time_on_datepicker.dart';

import '../../common/util/app_keyboard_util.dart';
import '../../common/widget/scaffold/bottom_dialog_scaffold.dart';
import '../../common/widget/w_round_button.dart';

//최종적으로 넘겨주고 싶은 타입 제네릭으로 표시
class WriteTodoDialog extends DialogWidget<Schedule> {
  final Schedule? scheduleForEdit;

  WriteTodoDialog({super.key, this.scheduleForEdit});

  @override
  DialogState<WriteTodoDialog> createState() => _WriteTodoDialogState();
}

class _WriteTodoDialogState extends DialogState<WriteTodoDialog>
    with AfterLayoutMixin {
  final double _textFieldWidth = 350;
  final double _textFieldHeight = 350;
  DateTime _selectedTime = DateTime.now();
  DateTime _seletedDate = DateTime.now();
  final _titleController = TextEditingController();
  final node = FocusNode();
  bool _isShowDatePicker = false;

  @override
  void initState() {
    super.initState();
    if (widget.scheduleForEdit != null) {
      //_seletedDate = widget.scheduleForEdit!.dueDate;
      // textController.text = widget.scheduleForEdit!.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomDialogScaffold(
        body: RoundedContainer(
      color: context.backgroundColor,
      child: Column(
        children: [
          Row(
            children: [
              TextField(
                focusNode: node,
                style: TextStyle(fontSize: bigFontSize), // 폰트 크기를 20으로 설정
                decoration: const InputDecoration(
                  border: InputBorder.none, // 하단 밑줄 없애기
                  hintText: '제목',
                ),
                controller: _titleController,
              ).w(_textFieldWidth),
              spacer,
            ],
          ),
          Row(
            children: [
              ShowTimeOnDatePicker.onDatePicker(_selectedTime.hour, _selectedTime.minute, _isShowDatePicker, () {
                setState(() {
                  _selectedTime
                });
              }, () { })
            ],
          ),
        ],
      ),
    ));
  }

  bool get isEditMode => widget.scheduleForEdit != null;

  // @override
  // FutureOr<void> afterFirstLayout(BuildContext context) {
  //   AppKeyboardUtil.show(context, node);
  //   throw UnimplementedError();
  // }
  void _selectDate() async {
    final date = await showDatePicker(
        context: context,
        initialDate: _seletedDate,
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365 * 10)));
    if (date != null) {
      setState(() {
        _seletedDate = date;
      });
    }
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    throw UnimplementedError();
  }
}
