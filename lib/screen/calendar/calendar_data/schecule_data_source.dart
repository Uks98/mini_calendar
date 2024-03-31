
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/publc_holiday.dart';

import '../../../controller/color_select_controller.dart';
import '../../../controller/month_data_controller.dart';
import 'd_schedule_data.dart';

class ScheduleDataSource extends CalendarDataSource {
  int colorIndex = 1;
  ColorSelectController colorController = Get.put(ColorSelectController());
  MonthControl monthController = Get.put(MonthControl());
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  ScheduleDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from ?? DateTime.now();
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to ?? DateTime.now();
  }
  @override
  String getSubject(int index) {
    return _getMeetingData(index).title!;
  }

  @override
  Color getColor(int cor) {
    return colorController.colorList.keys.elementAt(monthController.monthDataList[cor].colorIndex!);
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay!;
  }

  Schedule _getMeetingData(int index) {
    final dynamic schedule = appointments![index];
    late final Schedule scheduleData;
    if (schedule is Schedule) {
      scheduleData = schedule;
    }

    return scheduleData;
  }
}