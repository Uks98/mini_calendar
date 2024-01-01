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
import 'package:today_my_calendar/controller/color_select_controller.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/calendar/s_calendar_add_page.dart';
import 'package:today_my_calendar/tab/s_calendar_month_page.dart';

import '../../controller/map_data_controller.dart';
import '../controller/month_data_controller.dart';

class CalendarSearchPage extends StatefulWidget {
  CalendarSearchPage({
    super.key,
  });

  @override
  State<CalendarSearchPage> createState() => _CalendarSearchPageState();
}

class _CalendarSearchPageState extends State<CalendarSearchPage>
    with MonthControllerMix {
  final GlobalKey _otherKey = GlobalKey(); // Define a new GlobalKey.
  MapDataController mapDataController = Get.put(MapDataController());
  ColorSelectController _colorBox = Get.put(ColorSelectController());
  double searchGpsX = 0.0;
  double searchGpsY = 0.0;
  double textFieldLeftPadding = 20.0;
  Schedule? schedule;
  final TextEditingController _searchController = TextEditingController();

  String searchPlace = "";
  final options = const LiveOptions(
    // Start animation after (default zero)
    delay: Duration(seconds: 3),

    showItemInterval: Duration(seconds: 3),

    showItemDuration: Duration(seconds: 3),

    visibleFraction: 0.05,

    reAnimateOnVisibility: false,
  );

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
        title: "제목,위치,메모".text.size(bigFontSize).make(),
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
                    onTap: () {
                      if(_searchController.text.isEmpty){
                          monthControl.monthSearchList.clear();
                      }
                    },
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
                        hintText: '제목,내용을 입력하세요.',
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
                    child: LiveList.options(
                    options: options,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Height(smallHeight);
                    },
                    itemBuilder: (BuildContext context, int index,
                        Animation<double> animation) {
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
                          width: 200,
                          color: Colors.grey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "search.title!.textssssssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasssssssss".text
                                  .size(normalFontSize)
                                  .color(AppColors.brightGrey)
                                  .fontWeight(FontWeight.w300)
                                  .make(),
                              search.myPlace != null? search.myPlace!.text
                                  .size(smallFontSize)
                                  .color(AppColors.brightGrey)
                                  .fontWeight(FontWeight.w300)
                                  .make() : Container(),
                              search.myPlace != null? search.myPlace!.text
                                  .size(smallFontSize)
                                  .color(AppColors.brightGrey)
                                  .fontWeight(FontWeight.w300)
                                  .make() : Container(),

                            ],
                          ).paddingAll(smallHeight + 2.h),
                        ),
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
