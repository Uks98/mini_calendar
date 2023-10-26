
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_calendar/Color/widget_Color.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:get/get.dart';

import '../../controller/date_picker_controller.dart';
class QuickFixerDateWidget extends StatelessWidget with ScreenInit{
  QuickFixerDateWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final dtController = Get.put(DatePickerStateController());
    final dateChangeController = Get.put(DatePickerStateController());
    void addMinutes(int minutes) {
      dtController.lastSelectedTime.value = dtController.lastSelectedTime.value.add(Duration(minutes: minutes));
    }
    void resetDateTime(){
      dtController.lastSelectedTime.value = DateTime.now();
    }
    return ContextMenuArea(
        width: 200.w,
      builder: (context) => [
        TimeTileWidget(dateChangeController: dateChangeController,resetTime: resetDateTime, time: '0분',),
        TimeTileWidget(dateChangeController: dateChangeController,addMinute: () => addMinutes(5), time: '5분',),
        TimeTileWidget(dateChangeController: dateChangeController,addMinute: () => addMinutes(30), time: '30분',),
        TimeTileWidget(dateChangeController: dateChangeController,addMinute: () => addMinutes(60), time: '60분',),
        TimeTileWidget(dateChangeController: dateChangeController,addMinute: () => addMinutes(1440), time: '1일',),
      ],
      child: Obx(()=>SizedBox(
        child: dateChangeController.changeTimeText.value.text.size(normalFontSize).color(ColorBox.pickerText).align(TextAlign.right).size(normalFontSize.sp).make(),
      ),),
    );
  }
}

class TimeTileWidget extends StatelessWidget {
  TimeTileWidget({
    super.key,
    required this.dateChangeController,
    required this.time,
    this.addMinute,
    this.resetTime
  });

  final DatePickerStateController dateChangeController;
  VoidCallback? resetTime;
  VoidCallback? addMinute;
  String time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: time.text.size(normalFontSize).make(),
      onTap: () {
        dateChangeController.changeTimeText.value = time;
        if(time == "0분"){
        resetTime!();
        }else{
          addMinute!();
        }
        Navigator.of(context).pop();
      },
    );
  }
}
