import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/controller/month_data_controller.dart';

import '../screen/calendar/calendar_data/schecule_data_source.dart';

class CalendarDayPage extends StatefulWidget {
  const CalendarDayPage({super.key});

  @override
  State<CalendarDayPage> createState() => _CalendarDayPageState();
}

class _CalendarDayPageState extends State<CalendarDayPage> with MonthControllerMix {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>SfCalendar(
          allowAppointmentResize: true,
        dragAndDropSettings : DragAndDropSettings (
            allowNavigation : false),
        onDragStart: dragStart,
        onDragUpdate: dragUpdate,
       dataSource: ScheduleDataSource(monthControl.monthDataList.value),
        view: CalendarView.workWeek,
          ),
      ),
    );
  }
  void dragStart(AppointmentDragStartDetails appointmentDragStartDetails) {
    dynamic appointment = appointmentDragStartDetails.appointment;
    CalendarResource? resource = appointmentDragStartDetails.resource;
  }
  void dragUpdate(AppointmentDragUpdateDetails appointmentDragUpdateDetails) {
    dynamic appointment = appointmentDragUpdateDetails.appointment;
    DateTime? draggingTime = appointmentDragUpdateDetails.draggingTime;
    Offset? draggingOffset = appointmentDragUpdateDetails.draggingPosition;
    CalendarResource? sourceResource = appointmentDragUpdateDetails.sourceResource;
    CalendarResource? targetResource = appointmentDragUpdateDetails.targetResource;
  }
}
