import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/data/local/local_db.dart';

import '../screen/calendar/calendar_data/d_schedule_data.dart';
import '../screen/calendar/s_calendar_add_page.dart';
import '../screen/widget/d_message.dart';
import 'alarm_setting_controller.dart';

class MonthControl extends GetxController {
  LocalDB localDB = LocalDB.instance;
  RxList<Schedule> monthDataList = <Schedule>[].obs;
  RxList<Schedule> monthSearchList = <Schedule>[].obs;
  RxInt calendarSameDay = DateTime.now().day.obs;
  AlarmSettingController alarmSettingController = Get.put(AlarmSettingController());
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
          isAllDay: false,
          alarmSetText : "없음"
        ),
        isShowMap: false,
        initShowDetail: false,
      ),
    transition: Transition.downToUp,
      duration: const Duration(milliseconds: 200)
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
      duration: const Duration(milliseconds: 200),
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
      schedule.isAllDay = result.isAllDay;
      //if(result.alarmSetText)
      schedule.alarmSetText = result.alarmSetText;
      ///리스트 추가 및 갱신 함수
      localDB.updateDBSchedule(schedule);
    }
    monthDataList.refresh();
  }
  ///스케쥴 삭제
  Future<void> deleteSchedule(Schedule schedule)async{
    monthDataList.remove(schedule);
    await LocalDB.isar.writeTxn(()async{
      await LocalDB.isar.schedules.delete(schedule.id);
    });
  }
  ///캘린더 검색 함수
  void searchCalList({required String keyword,required BuildContext context}){
    if(keyword.isEmpty){
       monthDataList;
    }
    ///기존 리스트에 제목,위치,메모에 포함된 텍스트 검색시 리스트를 반환합니다.
     monthSearchList.value = monthDataList.where((element) => element.title!.contains(keyword) || element.myPlace!.contains(keyword) || element.memo!.contains(keyword)).toList();
    //getMapData(context, keyword);
    //print(autoCompleteList.toString());
  }

  void searchTitleList({required String keyword,required BuildContext context}){
    if(keyword.isEmpty){
      monthDataList;
    }
    ///기존 리스트에 일치하는 제목 검색시 해당 리스트를 반환합니다.
    monthSearchList.value = monthDataList.where((element) => element.title!.contains(keyword)).toList();
  }

  /// 검색창에 일치하는 일정이 있는지 없는지 판단하여 boolean을 리턴합니다.
 bool isContainSearchList(String keyword){
    final m = monthDataList.where((p0) => p0.title!.contains(keyword)).toList();
    if(m.isEmpty){
      return true;
    }else{
      return false;
    }
 }

}
///일정 검색

void showMessageDialog(BuildContext context,CalendarLongPressDetails calendarLongPressDetails) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return MessageDialog(
        "해당 일정을 삭제합니다.",
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
