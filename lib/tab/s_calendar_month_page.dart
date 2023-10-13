import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/widget/w_calendar_add_page.dart';
import 'package:today_my_calendar/screen/widget/w_calendar_content_bottom_sheet.dart';
import 'package:today_my_calendar/service/convert_locatoon_json_datal_ist.dart';

import '../controller/map_data_controller.dart';
import '../controller/month_data_controller.dart';
import '../screen/calendar/calendar_data/schecule_data_source.dart';

class CalendarMonthPage extends StatefulWidget with ScreenInit {
  const CalendarMonthPage({super.key});

  @override
  State<CalendarMonthPage> createState() => _CalendarMonthPageState();
}

class _CalendarMonthPageState extends State<CalendarMonthPage> with ScreenInit,MonthControllerMix {
  MapDataController mapDataController = Get.put(MapDataController());
  final CalendarController _calendarController = CalendarController();
  @override
  void initState() {
    super.initState();
  }

  // WriteTodoDialog calendarBottomSheet = WriteTodoDialog();
  @override
  Widget build(BuildContext context) {

    MonthControl monthControla = Get.put(MonthControl());
    screenInit(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
          monthControl.addSchedule(context);
          });
        }
      ),
      body: Obx(()=>SfCalendar(
        onTap: (cp) {
          calendarTapped(context,cp);
          setState(() {});
        },
        controller: _calendarController,
        headerHeight: 50.h,
        headerDateFormat: "M",
        view: CalendarView.month,
        dataSource: ScheduleDataSource(monthControla.monthDataList.value),
        monthViewSettings: const MonthViewSettings(
        appointmentDisplayCount: 4,
            showAgenda: true,
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),)
    );
  }
  void calendarTapped(
      BuildContext context, CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      Schedule event = calendarTapDetails.appointments![0];
      print("y = ${event.gpsY}");
      print("y = ${event.gpsX}");
      monthControl.editSchedule(event, context);
    }

  }
}

class EventView extends StatelessWidget {
  Schedule event;

  EventView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(event.from.toString()),
        ),
        Container(
          child: Text(event.to.toString()),
        ),
      ],
    );
  }
}

