import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/controller/month_data_controller.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/constant/app_colors.dart';
import '../../../common/theme/color/mix_find_theme.dart';
import '../../../common/widget/mixin/init_screen_size_utill.dart';
import '../../../controller/color_select_controller.dart';
import '../../../tab/s_main_screen.dart';

class TemPlatePage extends StatelessWidget
    with ThemeDarkFind, MonthControllerMix, ScreenInit {
  TemPlatePage({super.key, required this.calendarTapDetails, required this.schedule});
  Schedule schedule;
  CalendarTapDetails? calendarTapDetails;

  @override
  Widget build(BuildContext context) {
    Color changeSmallFloatingColor = !isLightMode
        ? context.appColors.calendarMainColor
        : context.appColors.floatingIconColor;
    print(calendarTapDetails!.date);
    final ColorSelectController _colorBox = Get.put(ColorSelectController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: changeSmallFloatingColor,
        onPressed: () => monthControl.addTemplate(context),
        child: const Icon(
          EvaIcons.fileAdd,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "템플릿"
              .text
              .size(biggerFontSize + 6)
              .make()
              .pOnly(left: normalWidth, top: normalHeight),
          Expanded(
            child: Obx(
              () => ListView.separated(
                  itemBuilder: (context, index) {
                    final templateList = monthControl.templateList[index];
                    return GestureDetector(
                      onTap: () {
                        final calendarDate = calendarTapDetails!.date;
                        Navigator.of(context).pop(
                            Schedule(
                              id: DateTime.now().microsecondsSinceEpoch,
                              title: templateList.title,
                              from: DateTime(
                                  calendarDate!.year,
                                  calendarDate.month,
                                  calendarDate.day,
                                  templateList.from!.hour,
                                  templateList.from!.minute),
                              to: DateTime(calendarDate.year, calendarDate.month, calendarDate.day, templateList.to!.hour, templateList.to!.minute),
                              colorIndex: templateList.colorIndex,
                              isAllDay: templateList.isAllDay ?? false,
                              isShowMap: templateList.isShowMap,
                              gpsY: templateList.gpsY,
                              gpsX: templateList.gpsX,
                              alarmSetText: templateList.alarmSetText,
                              memo: templateList.memo,
                              isTemplate:false,
                            )
                        );
                      },
                      //monthControl.editSchedule(monthControl.monthDataList[index], context),
                      //리펙토링 서치페이지 위젯과 함께 해야함
                      child: Container(
                        decoration: BoxDecoration(
                            color: isLightMode
                                ? AppColors.darkGrey
                                : context.appColors.settingListColor,
                            borderRadius: BorderRadius.circular(smallWidth)),
                        child: Row(
                          children: [
                            Width(smallWidth),
                            VxBox()
                                .width(smallWidth)
                                .height(50.h)
                                .withRounded(value: 2.w)
                                .color(_colorBox.colorList.keys
                                    .elementAt(templateList.colorIndex!))
                                .make(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 280.w,
                                  child: templateList.title!.text
                                      .size(bigFontSize)
                                      .fontWeight(FontWeight.w300)
                                      .overflow(TextOverflow.ellipsis)
                                      .color(isLightMode
                                          ? Colors.white
                                          : context.appColors.text)
                                      .make(),
                                ),
                                HeightBox(smallHeight),
                                "${templateList.to!.hour < 12 ? "오전" : "오후"} ${templateList.from!.hour}시 ${templateList.from!.minute}분  ~ "
                                        " ${returnToMonDay(templateList.from!.month, templateList.to!.month, templateList.from!.day, templateList.to!.day, templateList.to!.hour, templateList.to!.minute)}"
                                    .text
                                    .size(smallFontSize)
                                    .color(isLightMode
                                        ? Colors.white
                                        : Colors.black)
                                    .make(),
                                templateList.myPlace != null
                                    ? templateList.myPlace!.text
                                        .size(smallFontSize)
                                        .color(isLightMode
                                            ? Colors.white
                                            : Colors.black)
                                        .fontWeight(FontWeight.w300)
                                        .make()
                                    : const SizedBox(),
                              ],
                            ).paddingAll(smallHeight.h),
                            IconButton(onPressed: ()=> monthControl.editTemplate(templateList,context), icon: const Icon(EvaIcons.editOutline,size: 30,))
                          ],
                        ).marginAll(2.w),
                      ).paddingAll(normalWidth),
                    );
                  },
                  separatorBuilder: (ctx, index) => HeightBox(normalWidth),
                  itemCount: monthControl.templateList.length),
            ),
          )
        ],
      ),
    );
  }
}
