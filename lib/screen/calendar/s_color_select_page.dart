import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/screen/widget/w_custom_show_bottom_sheet.dart';

import '../../common/constant/constant_widget.dart';
import '../../controller/color_select_controller.dart';

class ColorSelectPage extends StatefulWidget {
  const ColorSelectPage({super.key});

  @override
  State<ColorSelectPage> createState() => _ColorSelectPageState();
}
CustomBottomSheet customBottomSheet = CustomBottomSheet(); //바텀 시트 불러오기
ColorSelectController colorController = Get.put(ColorSelectController());

class _ColorSelectPageState extends State<ColorSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        "색상".text.size(normalFontSize).make(),
        SizedBox(width: smallWidth,),
        Tap(
          onTap: (){
            customBottomSheet.showCustomBottomSheet(context,radius: 20.0.w,title: "이벤트 색상");
          },
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(smallHeight),
            ),
          ).pOnly(right: bigWidth),
        )
      ],
    );
  }

}
