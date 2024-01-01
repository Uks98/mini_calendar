import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/data/local/local_db.dart';

import '../screen/calendar/calendar_data/d_schedule_data.dart';
import '../screen/calendar/s_calendar_add_page.dart';
import '../screen/widget/d_message.dart';

class MonthControl extends GetxController {
  LocalDB localDB = LocalDB.instance;
  RxList<Schedule> monthDataList = <Schedule>[].obs;
  RxInt calendarSameDay = DateTime.now().day.obs;
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();
  //RxBool isDarkMode = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToInitList();
  }

  //id
  int get newId {
    return DateTime.now().microsecondsSinceEpoch;
  }

  void getToInitList()async{
    final getMeetingList = await localDB.getTodoList();
    monthDataList.addAll(getMeetingList);
  }

  ///스케쥴 추가
  void addSchedule(BuildContext context,DateTime startDate,DateTime endDate) async {
    final result = await Get.to<Schedule>(
      CalendarAddPage(
        schedule: Schedule(
          id : newId,
          title: '',
          to: startDate,
          from: endDate,
          gpsX: 0.0,
          gpsY: 0.0,
          memo: '',
          myPlace: '',
          colorIndex: 0,
          isShowMap: false,
        ),
        isShowMap: false,
        initShowDetail: false,
      ),
    transition: Transition.downToUp,
      duration: const Duration(milliseconds: 300)
      );
    if (result != null) {
      ///리스트 추가 및 갱신 함수
      monthDataList.add(result); //달력 아이템 리스트
      localDB.addDBSchedule(result);
    }
      monthDataList.refresh();
  }

  ///캘린더를 탭했을 때 생기는 이벤트 함수
  void calendarTapped(
      BuildContext context, CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      Schedule event = calendarTapDetails.appointments![0];
      editSchedule(event, context);
    }
  }

  ///캘린더를 롱 탭 했을 때 생기는 이벤트 함수
  void calendarLongTapped(
      BuildContext context, CalendarLongPressDetails calendarLongPressDetails){

    if (calendarLongPressDetails.targetElement == CalendarElement.appointment) {
      Schedule event = calendarLongPressDetails.appointments![0];
      deleteSchedule(event);
    }
  }
  ///스케쥴 업데이트
  void editSchedule(Schedule schedule, BuildContext context) async {
    final result = await Get.to(
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 250),
      CalendarAddPage(
                schedule: schedule,
            isShowMap: true,
        initShowDetail: true,
          ),
      );
    if (result != null) {
      schedule.title = result.title;
      schedule.memo = result.memo;
      schedule.to = result.to;
      schedule.from = result.from;
      if(schedule.myPlace == '' || schedule.myPlace!.isEmpty){
        schedule.myPlace = "없음";
      }
      schedule.myPlace = result.myPlace;
      schedule.gpsX = result.gpsX;
      schedule.gpsY = result.gpsY;
      schedule.colorIndex = result.colorIndex;
      ///리스트 추가 및 갱신 함수
      localDB.updateDBSchedule(schedule);
    }

    monthDataList.refresh();
  }
  //스케쥴 삭제
  Future<void> deleteSchedule(Schedule schedule)async{
    monthDataList.remove(schedule);
    await LocalDB.isar.writeTxn(()async{
      await LocalDB.isar.schedules.delete(schedule.id);
    });
  }
}


void showMessageDialog(BuildContext context,CalendarLongPressDetails calendarLongPressDetails) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return MessageDialog(
        "이 일정을 삭제하겠습니다?",
        positiveButtonText: "삭제",
        negativeButtonText: "취소",
        fontSize: 16,
        cancelable: false,
        textAlign: TextAlign.center,
        calendarLongPressDetails: calendarLongPressDetails,
      );
    },
  );
}

mixin class MonthControllerMix {
  late MonthControl monthControl = Get.put(MonthControl());
}
