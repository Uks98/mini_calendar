import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

import '../../controller/alarm_setting_controller.dart';

class AlarmSettingTile extends StatefulWidget {
  String? alarmInitText;

  AlarmSettingTile({super.key, required this.alarmInitText});

  @override
  State<AlarmSettingTile> createState() => _AlarmSettingTileState();
}

class _AlarmSettingTileState extends State<AlarmSettingTile> {
  AlarmSettingController alarmController = Get.put(AlarmSettingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.alarmInitText != null) {
      alarmController.alarmTime.value = widget.alarmInitText.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        "알림"
            .text
            .size(normalFontSize)
            .fontWeight(
              FontWeight.w300,
            )
            .make()
            .paddingOnly(left: 4.w),
        ContextMenuArea(
          builder: (context) => [
            buildAlarmListTile(alarmController, "없음", context),
            buildAlarmListTile(alarmController, "지정 시간", context),
            buildAlarmListTile(alarmController, "1분 전", context),
            buildAlarmListTile(alarmController, "5분 전", context),
            buildAlarmListTile(alarmController, "30분 전", context),
            buildAlarmListTile(alarmController, "1시간 전", context),
          ],
          child: Obx(() => alarmController.alarmTime.value.text
              .size(bigFontSize)
              .fontWeight(
                FontWeight.w300,
              )
              .make()
              .pOnly(
            right: 20.w,
                  left: isTextLengthPadding(alarmController.alarmTime.value)
                      ? 270.w
                      : 265.w),),
        ),
      ],
    );
  }

  ///buildAlarmListTile을 선택했을 경우에만 alarmController을 통해 알람이 전달이 된다.
  ListTile buildAlarmListTile(AlarmSettingController alarmController,
      String alarmText, BuildContext context) {
    return ListTile(
      title: alarmText.text
          .size(bigFontSize)
          .fontWeight(
            FontWeight.w300,
          )
          .make(),
      onTap: () {
        setState(() {
          widget.alarmInitText = alarmText;
        });
        if (widget.alarmInitText == null) {
          alarmController.alarmTime.value = alarmText;
        }
        alarmController.alarmTime.value = alarmText;

        Navigator.of(context).pop();
      },
    );
  }

  bool isTextLengthPadding(String text) {
    if (text.length > 2) {
      return false;
    } else {
      return true;
    }
  }
}
