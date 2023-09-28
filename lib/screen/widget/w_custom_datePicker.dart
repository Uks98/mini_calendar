import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:today_my_calendar/Color/widget_Color.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
import '../../common/constant/constant_widget.dart';
import '../../controller/date_picker_controller.dart';
import 'package:get/get.dart';

class ShowDatePicker extends StatelessWidget with ScreenInit{
  String startText;
  DateTime dateTime;

  ShowDatePicker({
    super.key,
    required this.startText,
    required this.datePickerStateController,
    required this.dateTime,
  });
  DateTime get _selectedDate => datePickerStateController.startSelectedTime.value;
  final DatePickerStateController datePickerStateController;


  @override
  Widget build(BuildContext context) {
    int timeTextLeftPaddingSize = 130;
    screenInit(context);
    return Row(
      children: [
        Tap(
          onTap: ()=> datePickerStateController.showStartPicker(),
          child:Obx(()=>Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    "${startText}".text.size(bigFontSize).make(),
                    ///패딩 값 수정
                    Obx(()=>"${dateTime.month}월 ${dateTime.day}일  ${_selectedDate.hour} : ${_selectedDate.minute}분"
                        .text
                        .size(bigFontSize).color(ColorBox.pickerText)
                        .make()).pOnly(left:timeTextLeftPaddingSize.w )
                  ],
                ),
              ).w(360),
              if (datePickerStateController.isShowStartDatePicker.value)
                SizedBox(
                  child: Center(
                    child: CupertinoDatePicker(
                      dateOrder: DatePickerDateOrder.ymd,
                      minimumYear: 2010,
                      maximumYear: DateTime.now().year,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (date) =>datePickerStateController.startTimeChanged(date),
                      mode: CupertinoDatePickerMode.time,
                    ),
                  ),
                ).w(350).h(100),
            ],
          ),
          ),),
      ],
    );
  }
}