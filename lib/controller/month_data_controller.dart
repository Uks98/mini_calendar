import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/data/local/local_db.dart';

import '../screen/calendar/calendar_data/d_schedule_data.dart';
import '../screen/widget/w_calendar_add_page.dart';

class MonthControl extends GetxController {
  LocalDB localDB = LocalDB.instance;
  RxList<Schedule> monthDataList = <Schedule>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToInitList();
  }

  void addSchedule(BuildContext context) async {
    final result = await Navigator.push<Schedule>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CalendarAddPage(
          schedule: Schedule(
            id : null,
            title: '',
            to: DateTime.now(),
            from: DateTime.now(),
            gpsX: 0.0,
            gpsY: 0.0,
            memo: '',
            myPlace: '',
            colorIndex: 0,
          ),
          isShowMap: false,
        ),
      ),
    );
    if (result != null) {
      ///리스트 추가 및 갱신 함수
      monthDataList.add(result); //달력 아이템 리스트
      localDB.addDBSchedule(result);
    }
      monthDataList.refresh();
  }

  void getToInitList()async{
    final getMeetingList = await localDB.getTodoList();
    monthDataList.addAll(getMeetingList);
  }

  void editSchedule(Schedule schedule, BuildContext context) async {
    final result = await Navigator.push<Schedule>(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => CalendarAddPage(
                schedule: schedule,
            isShowMap: true,
          ),
      ),
    );
    if (result != null) {
      schedule.title = result.title;
      schedule.to = result.to;
      schedule.from = result.from;
      if(schedule.myPlace == '' || schedule.myPlace.isEmpty){
        schedule.myPlace = "없음";
      }
      schedule.myPlace = result.myPlace;
      schedule.gpsX = result.gpsX;
      schedule.gpsY = result.gpsY;
      schedule.colorIndex = result.colorIndex;
      ///리스트 추가 및 갱신 함수
      print("result ${result.id}");
      localDB.updateDBSchedule(schedule);
    }
    monthDataList.refresh();
  }
}

mixin class MonthControllerMix {
  late MonthControl monthControl = Get.put(MonthControl());
}
