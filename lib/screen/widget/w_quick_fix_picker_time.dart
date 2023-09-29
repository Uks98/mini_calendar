
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
    final dateChangeController = Get.put(DatePickerStateController());
    return ContextMenuArea(
        width: 200.w,
      builder: (context) => [
        ListTile(
          title: "0분".text.make(),
          onTap: () {
            dateChangeController.addTime.value = 0;
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          title: "5분".text.make(),
          onTap: () {
            dateChangeController.addTime.value = 5;
            dateChangeController.changeTimeText.value = "5분";
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          title: "30분".text.make(),
          onTap: () {
            dateChangeController.addTime.value = 30;
            dateChangeController.changeTimeText.value = "30분";
            Navigator.of(context).pop();
          },
        ),
      ],
      child: Obx(()=>SizedBox(
        child: dateChangeController.changeTimeText.value.text.color(ColorBox.pickerText).align(TextAlign.right).size(normalFontSize.sp).make(),
      ),),
    );
  }
}
