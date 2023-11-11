import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

import '../../controller/alarm_setting_controller.dart';

class AlarmSettingTile extends StatelessWidget {
  const AlarmSettingTile({super.key});
  @override
  Widget build(BuildContext context) {
    AlarmSettingController alarmController = Get.put(AlarmSettingController());
    return Container(
      child: Row(

        children: [
          "알림".text.size(normalFontSize).fontWeight(FontWeight.w300,).make().paddingOnly(left: 4.w),
      ContextMenuArea(
        width: 230.w,
        builder: (context) => [
         buildAlarmListTile(alarmController,"없음",context),
         buildAlarmListTile(alarmController,"지정 시간",context),
         buildAlarmListTile(alarmController,"1분 전",context),
         buildAlarmListTile(alarmController,"5분 전",context),
         buildAlarmListTile(alarmController,"30분 전",context),
         buildAlarmListTile(alarmController,"1시간 전",context),
        ],
        child: Obx(()=>alarmController.alarmTime.value.text.size(bigFontSize).fontWeight(FontWeight.w300,).make().pOnly(left: isTextLengthPadding(alarmController.alarmTime.value) ? 270.w : 255.w),
      ))
        ],
      ),
    );
  }

  ListTile buildAlarmListTile(AlarmSettingController alarmController,String alarmText,BuildContext context) {
    return ListTile(title: alarmText.text.size(bigFontSize).fontWeight(FontWeight.w300,).make(),onTap: (){
          alarmController.alarmTime.value = alarmText;
          Navigator.of(context).pop();
        },);
  }
  bool isTextLengthPadding(String text){
    if(text.length > 2){
      return false;
    }else{
      return true;
    }
  }
}
