import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
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
  MapApi mapApi = MapApi();
  void getMapData() async {
    mapDataController.mapList.value = (await mapApi.getMapList(context: context))!;
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    getMapData();
  }

  // WriteTodoDialog calendarBottomSheet = WriteTodoDialog();
  @override
  Widget build(BuildContext context) {
    MonthControl m = Get.put(MonthControl());
    screenInit(context);
    return Scaffold(
      body: SfCalendar(
        headerHeight: 80.h,
        onLongPress: (dateTime) async {
          final result = await WriteTodoDialog(
            calendarDateTime: dateTime.date!,
          ).show();
          if (result != null) {
           m.addItem(result);
           setState(() {});
          }
        },
        headerDateFormat: "M",
        view: CalendarView.month,
        dataSource: ScheduleDataSource(monthControl.monthDataList),
        monthViewSettings: const MonthViewSettings(
        appointmentDisplayCount: 3,
            showAgenda: true,
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
    );
  }

}

