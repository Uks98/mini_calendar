import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/calendar/s_color_select_page.dart';
import 'package:today_my_calendar/screen/widget/w_calendar_add_page.dart';

import '../calendar/calendar_data/d_schedule_data.dart';

class CustomBottomSheet {
  Future showCustomBottomSheet(BuildContext context,
      {required double radius, required String title}) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 300.h,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Height(normalHeight),
              title.text.size(bigFontSize).make(),
              Height(normalHeight),
              Stack(
                children: [
                  VxBox()
                      .color(AppColors.brightGrey)
                      .width(300.w)
                      .height(200.h)
                      .withRounded(value: 10.w)
                      .make(),
                  SizedBox(
                    width: colorCircleSize,
                    height: colorCircleSize,
                    child: Obx(()=>GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: colorController.colorList.value.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 열의 개수 설정
                        ),
                        itemBuilder: (context, index) {
                          final color = colorController.colorList.value[index];
                          colorController.selectIndex.value = index;
                          return GestureDetector(
                              onTap: (){
                                colorController.selectIndex.value = index;
                                Navigator.of(context).pop(index);
                              },
                              child: Obx(()=>circleOutlined(color, listIndex: index, checkIndex: colorController.selectIndex.value)));
                        }),
                  ).pOnly(left: normalHeight, top: normalHeight),),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget circleOutlined(Color color,
      {required listIndex, required checkIndex}) {
    return Stack(children: [
      VxBox()
          .width(30)
          .height(30)
          .withRounded(value: smallWidth + 3.w)
          .color(color)
          .make(),
        checkIndex == listIndex
          ? Icon(
              Icons.check,
              size: bigHeight,
              color: AppColors.brightGrey,
            ).pOnly(left: smallWidth, top: smallHeight)
          : const SizedBox(),
    ]);
  }
}
