import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:after_layout/after_layout.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/widget/w_custom_datePicker.dart';
import 'package:today_my_calendar/screen/widget/w_quick_fix_picker_time.dart';
import 'package:today_my_calendar/screen/widget/w_rounded_container.dart';
import '../../common/widget/mixin/init_screen_size_utill.dart';
import '../../common/widget/scaffold/bottom_dialog_scaffold.dart';
import '../../controller/alarm_setting_controller.dart';
import '../../controller/date_picker_controller.dart';
import 'alarm_setting_Tile.dart';

//최종적으로 넘겨주고 싶은 타입 제네릭으로 표시
class WriteTodoDialog extends DialogWidget<Schedule> {
  final DateTime calendarDateTime;
  final Schedule? scheduleForEdit;

  WriteTodoDialog({super.key, this.scheduleForEdit,required this.calendarDateTime});

  @override
  DialogState<WriteTodoDialog> createState() => _WriteTodoDialogState();
}

class _WriteTodoDialogState extends DialogState<WriteTodoDialog>
    with AfterLayoutMixin,ScreenInit {
  final double _textFieldWidth = 350;
  final double _textFieldHeight = 350;
  final double _quickWidgetLeftPadding = 270;

  final _titleController = TextEditingController();
  final node = FocusNode();
  //controller
  DatePickerStateController datePickerStateController = Get.put(DatePickerStateController());
  RxBool get isShowStartPicker => datePickerStateController.isShowStartDatePicker;
  RxBool get isShowLastPicker => datePickerStateController.isShowLastDatePicker;
  final alarmSet = Get.put(AlarmSettingController());
  @override
  void initState() {
    super.initState();
    datePickerStateController = Get.put(DatePickerStateController());
    if (widget.scheduleForEdit != null) {
      //_seletedDate = widget.scheduleForEdit!.dueDate;
      // textController.text = widget.scheduleForEdit!.title;
    }

  }

  @override
  Widget build(BuildContext context) {
    screenInit(context);
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
          ///시작 시간
          ShowDateStartPicker(dateTime : widget.calendarDateTime, startText: "시작",datePickerStateController: datePickerStateController,),
          ///종료 시간
          ShowDateLastPicker(dateTime : widget.calendarDateTime,startText: "종료",datePickerStateController: datePickerStateController,),
          ///시간 분 단위로 올리기
          QuickFixerDateWidget().pOnly(top: middleHeight.h,left: _quickWidgetLeftPadding.w),
          ///알람 설정
           AlarmSettingTile(),
          IconButton(onPressed: (){
            final startTime = datePickerStateController.startSelectedTime.value;
            final lastTime = datePickerStateController.lastSelectedTime.value;
          alarmSet.getAlarmTime(time: lastTime, setTextTime: "1분", context: context);
          widget.hide(Schedule(from: datePickerStateController.startSelectedTime.value, to: datePickerStateController.lastSelectedTime.value));
          }, icon: Icon(Icons.check))
        ],
      ).pOnly(left: 10.w),

    )
    );
  }

  bool get isEditMode => widget.scheduleForEdit != null;

  // @override
  // FutureOr<void> afterFirstLayout(BuildContext context) {
  //   AppKeyboardUtil.show(context, node);
  //   throw UnimplementedError();
  // }
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    throw UnimplementedError();
  }
}


