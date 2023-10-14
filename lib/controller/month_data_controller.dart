import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/calendar/calendar_data/d_schedule_data.dart';
import '../screen/widget/w_calendar_add_page.dart';

class MonthControl extends GetxController {
  RxList<Schedule> monthDataList = <Schedule>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void addSchedule(BuildContext context) async {
    final result = await Navigator.push<Schedule>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CalendarAddPage(
          schedule: Schedule(
            title: '',
            to: DateTime.now(),
            from: DateTime.now(),
            gpsX: 0.0,
            gpsY: 0.0,
            memo: '',
            myPlace: '',
          ),
          isShowMap: false,
        ),
      ),
    );
    if (result != null) {
      ///리스트 추가 및 갱신 함수
      monthDataList.add(result); //달력 아이템 리스트
    }
      monthDataList.refresh();
  }

  void editSchedule(Schedule schedule, BuildContext context) async {
    final result = await Navigator.push<Schedule>(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => CalendarAddPage(
                schedule: schedule,
            isShowMap: true,
              ),),
    );
    if (result != null) {
      schedule.title = result.title;
      schedule.to = result.to;
      schedule.from = result.from;
      schedule.myPlace = result.myPlace;
      schedule.gpsX = result.gpsX;
      schedule.gpsY = result.gpsY;

      ///리스트 추가 및 갱신 함수
    }
    monthDataList.refresh();
  }
}

mixin class MonthControllerMix {
  late MonthControl monthControl = Get.put(MonthControl());
}
