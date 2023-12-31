import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/theme/color/mix_find_theme.dart';
import 'package:today_my_calendar/controller/color_select_controller.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/calendar/s_calendar_add_page.dart';
import 'package:today_my_calendar/tab/s_calendar_month_page.dart';

import '../../controller/map_data_controller.dart';
import '../common/data/preference/prefs.dart';
import '../common/theme/theme_util.dart';
import '../controller/month_data_controller.dart';
import '../screen/setting/w_switch.dart';

class CalendarSearchPage extends StatefulWidget {
  CalendarSearchPage({
    super.key,
  });

  @override
  State<CalendarSearchPage> createState() => _CalendarSearchPageState();
}

class _CalendarSearchPageState extends State<CalendarSearchPage>
    with MonthControllerMix,ThemeDarkFind{

  ///검색 기능 중 월,일이 시작 일정과 동일할 경우 가독성을 위해 불필요한 텍스트를 줄이는 함수
  String returnToMonDay(int fromMonth,int toMonth,int fromDay,int toDay ,int hour,int minute){
    if(fromMonth == toMonth && fromDay == toDay){
      return "${hour < 12 ? "오전" : "오후"} $hour시 $minute분";
    }
    return "$toMonth월 $toDay일 ${hour < 12 ? "오전" : "오후"} $hour시 $minute분";
  }

  MapDataController mapDataController = Get.put(MapDataController());
  ColorSelectController _colorBox = Get.put(ColorSelectController());
  double textFieldLeftPadding = 20.0;
  Schedule? schedule;
  bool get isLightModes =>  Prefs.isLightModes.get();
  final TextEditingController _searchController = TextEditingController();

  String searchPlace = "";

  @override
  void initState() {
    monthControl.monthSearchList.clear();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "검색".text.size(bigFontSize).make(),
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.search_outlined),
                SizedBox(
                  width: 200.w,
                  child: TextField(
                    autofocus: false,
                    onChanged: (value) => monthControl.searchCalList(
                        keyword: value, context: context),
                    style: TextStyle(
                        fontSize: normalFontSize + 2,
                        fontWeight: FontWeight.w300),
                    // 폰트 크기를 20으로 설정
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        border: InputBorder.none, // 하단 밑줄 없애기
                        hintText: '제목,위치 및 메모',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300)
                        //hintStyle: TextStyle(color: )
                        ),
                    controller: _searchController,
                  ).w(200).pOnly(left: textFieldLeftPadding),
                ),
              ],
            ).pOnly(left: textFieldLeftPadding),
            Obx(() => monthControl.monthSearchList.isNotEmpty
                ? SingleChildScrollView(
                    child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Height(2);
                    },
                    itemBuilder: (BuildContext context, int index,) {
                      final search = monthControl.monthSearchList[index];
                      return GestureDetector(
                        onTap: () {
                          monthControl.editSchedule(
                              Schedule(
                                  id: 0,
                                  title: search.title,
                                  memo: search.memo,
                                  from: search.from,
                                  to: search.to,
                                  myPlace: search.myPlace,
                                  gpsX: search.gpsX,
                                  gpsY: search.gpsY,
                                  colorIndex: search.colorIndex,
                                  isShowMap: search.isShowMap),
                              context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                          color: isLightModes ? AppColors.darkGrey :context.appColors.settingListColor,
                              borderRadius: BorderRadius.circular(smallWidth)),
                          child: Row(
                            children: [
                              Width(smallWidth),
                              VxBox()
                              .width(smallWidth)
                              .height(50.h).withRounded(value: 2.w)
                              .color(_colorBox.colorList.keys.elementAt(search.colorIndex!))
                              .make(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  search.title!.text
                                      .size(bigFontSize).fontWeight(FontWeight.w300)
                                      .color(isLightMode ? Colors.white :context.appColors.text)
                                      .make(),
                                  " ${search.to!.year}년 ${search.from!.month}월 ${search.from!.day}일 ${search.to!.hour < 12 ? "오전" : "오후"} ${search.from!.hour}시 ${search.from!.minute}분  ~ "
                                  " ${returnToMonDay(search.from!.month,search.to!.month,search.from!.day,search.to!.day,search.to!.hour,search.to!.minute)}".text.size(smallFontSize).color(isLightModes ? Colors.white : Colors.black).make(),


                                  search.myPlace != null? search.myPlace!.text
                                      .size(smallFontSize)
                                      .color(isLightModes ? Colors.white : Colors.black)
                                      .fontWeight(FontWeight.w300)
                                      .make() : Container(),

                                ],
                              ).paddingAll(smallHeight.h),
                            ],
                          ).marginAll(2.w),
                        ).paddingAll(normalWidth),
                      );
                    },
                    itemCount: monthControl.monthSearchList.length,
                  ).pOnly(left: smallWidth))
                : Container()),
          ],
        ),
      ),
    );
  }
}
