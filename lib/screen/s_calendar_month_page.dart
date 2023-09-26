import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/screen/widget/w_calendar_content_bottom_sheet.dart';

import 'calendar/calendar_data/d_schedule_data.dart';

class CalendarMonthPage extends StatefulWidget {
  const CalendarMonthPage({super.key});

  @override
  State<CalendarMonthPage> createState() => _CalendarMonthPageState();
}

class _CalendarMonthPageState extends State<CalendarMonthPage> {
  WriteTodoDialog calendarBottomSheet = WriteTodoDialog();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SfCalendar(
          headerHeight: 80,
          onTap: (date){
            WriteTodoDialog().show();
          },
          headerDateFormat: "M",
          view: CalendarView.month,
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ));
  }
  List<Schedule> _getDataSource() {
    final List<Schedule> meetings = <Schedule>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    // meetings.add(Schedule(
    //     'Conference', '', startTime, endTime, (0xFF0F8644), true));
    return meetings;
  }
}
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Schedule> source) {
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



  Schedule _getMeetingData(int index) {
    final dynamic schedule = appointments![index];
    late final Schedule meetingData;
    if (schedule is Schedule) {
      meetingData = schedule;
    }

    return meetingData;
  }
}


