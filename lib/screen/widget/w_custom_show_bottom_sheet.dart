import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/calendar/s_color_select_page.dart';

import '../../common/theme/color/mix_find_theme.dart';

class CustomBottomSheet with ThemeDarkFind{
  Future showCustomBottomSheet(BuildContext context,
      {required double radius,
        required String title})
  {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      builder: (BuildContext context) {
        findDarkMode(context);
        return FractionallySizedBox(
          heightFactor: 1.0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Height(normalHeight),
                title.text.size(bigFontSize).make(),
                Height(normalHeight),
                Expanded(
                  child: SizedBox(
                    width: colorSelectPageHeight,
                    child: Obx(() => ListView.separated(
                          itemCount:
                              colorController.colorList.value.entries.length,
                          itemBuilder: (context, index) {
                            var entry = colorController
                                .colorList.value.entries
                                .elementAt(index);
                            return Obx(() => GestureDetector(
                              onTap: () {
                                colorController.selectIndex.value = index;
                                Navigator.of(context).pop(index);
                              },
                              child: Row(children: [
                                circleOutlined(entry.key,
                                    listIndex: index,
                                    checkIndex:
                                    colorController.selectIndex.value),
                                Width(normalWidth),
                                entry.value.text.color(isLightMode ? Colors.white : Colors.black).fontWeight(FontWeight.w300).make(),
                              ],),
                            ),);
                          },
                          separatorBuilder: (BuildContext ctx, int idx) {
                            return const sep_col_height();
                          },
                        )).pOnly(left: normalHeight, top: normalHeight),
                  ),
                ),
              HeightBox(normalHeight),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget circleOutlined(Color color,
      {required listIndex, required checkIndex}) {
    return Stack(children: [
      VxBox()
          .width(30.w)
          .height(30.h)
          .withRounded(value: smallWidth)
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

class sep_col_height extends StatelessWidget {
  const sep_col_height({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: smallHeight),
        Divider(
          indent: 1.w,
          endIndent: 10.w,
          thickness: 0.8,
          color: Colors.grey[500],
        ),
        SizedBox(height: smallHeight),
      ],
    );
  }
}
