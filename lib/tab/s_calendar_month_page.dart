import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/widget/w_calendar_add_page.dart';
import '../controller/map_data_controller.dart';
import '../controller/month_data_controller.dart';
import '../screen/calendar/calendar_data/schecule_data_source.dart';

class CalendarMonthPage extends StatefulWidget with ScreenInit {
  const CalendarMonthPage({
    super.key,
  });

  @override
  State<CalendarMonthPage> createState() => _CalendarMonthPageState();
}

class _CalendarMonthPageState extends State<CalendarMonthPage>
    with ScreenInit, MonthControllerMix {
  MapDataController mapDataController = Get.put(MapDataController());
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MonthControl monthControla = Get.put(MonthControl());
    screenInit(context);
    return Scaffold(
      key: GlobalKey<_CalendarMonthPageState>(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              monthControl.addSchedule(context);
            });
          }).pOnly(bottom: 20),
      body: Column(
        children: [
          Obx(
            () =>
              Expanded(
                child: SfCalendar(
                  onTap: (cp) {
                    calendarTapped(context, cp);
                    setState(() {});
                  },
                  controller: _calendarController,
                  headerHeight: 50.h,
                  headerDateFormat: "M",
                  view: CalendarView.month,
                  dataSource:
                      ScheduleDataSource(monthControla.monthDataList.value),
                  monthViewSettings: MonthViewSettings(
                    agendaViewHeight: 200.0.h,
                      monthCellStyle: const MonthCellStyle(
                          textStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              color: Colors.black),
                          trailingDatesTextStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              color: Colors.black),
                          leadingDatesTextStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              color: Colors.black),

                          todayBackgroundColor: Colors.blue,
                          leadingDatesBackgroundColor: Colors.grey,
                          trailingDatesBackgroundColor: Colors.grey),
                      dayFormat: "EEE",
                      agendaStyle: AgendaStyle(
                          backgroundColor: Colors.black,
                          appointmentTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontStyle: FontStyle.italic),
                          dayTextStyle: TextStyle(
                              color: AppColors.brightGrey,
                              fontSize: 13,
                              fontStyle: FontStyle.italic),
                          dateTextStyle: TextStyle(
                              color: AppColors.brightGrey,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)),
                      appointmentDisplayCount: 4,
                      showAgenda: true,
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.indicator),
                ),
              ),

          ),
        ],
      ),
    );
  }

  void calendarTapped(
      BuildContext context, CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      Schedule event = calendarTapDetails.appointments![0];
      print("abcs${event.myPlace}");
      monthControl.editSchedule(event, context);
    }
  }
}
