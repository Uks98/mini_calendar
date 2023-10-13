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
  CalendarController _calendarController = CalendarController();
  @override
  void initState() {
    super.initState();
  }

  // WriteTodoDialog calendarBottomSheet = WriteTodoDialog();
  @override
  Widget build(BuildContext context) {
    MonthControl monthControl = Get.put(MonthControl());
    screenInit(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          final result = await Navigator.push<Schedule>(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>  CalendarAddPage()),
          );
           if (result != null) {
             ///리스트 추가 및 갱신 함수
             monthControl.addItem(result);
             print(result.gpsX);
             setState(() {});
           }}
      ),
      body: SfCalendar(
        controller: _calendarController,
        headerHeight: 80.h,
        headerDateFormat: "M",
        view: CalendarView.month,
        dataSource: ScheduleDataSource(monthControl.monthDataList),
        monthViewSettings: const MonthViewSettings(
        appointmentDisplayCount: 4,
            showAgenda: true,
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
    );
  }

}

