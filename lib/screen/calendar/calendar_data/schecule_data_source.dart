
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'd_schedule_data.dart';

class ScheduleDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  ScheduleDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }
  @override
  String getSubject(int index) {
    return _getMeetingData(index).title;
  }
  @override
  Color getColors(int index) {
    return Colors.amber;
  }

  Schedule _getMeetingData(int index) {
    final dynamic schedule = appointments![index];
    late final Schedule meetingData;
    if (schedule is Schedule) {
      meetingData = schedule;
    }

    return meetingData;
  }
}