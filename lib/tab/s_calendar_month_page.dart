import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/tab/s_setting_page.dart';
import '../controller/alarm_setting_controller.dart';
import '../controller/month_data_controller.dart';
import '../screen/calendar/calendar_data/schecule_data_source.dart';
import '../screen/calendar/s_calendar_add_page.dart';

class CalendarMonthPage extends StatefulWidget with ScreenInit {
  const CalendarMonthPage({
    super.key,
  });

  @override
  State<CalendarMonthPage> createState() => _CalendarMonthPageState();
}

class _CalendarMonthPageState extends State<CalendarMonthPage>
    with ScreenInit, MonthControllerMix {
  final CalendarController _calendarController = CalendarController();
  AlarmSettingController alarmController = Get.put(AlarmSettingController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    screenInit(context);
    return Scaffold(
      key: GlobalKey<_CalendarMonthPageState>(),
      floatingActionButton:FloatingActionButton(
         backgroundColor: context.appColors.calendarMainColor,
           child: Icon(Icons.add,color: context.appColors.floatingIconColor,),
           onPressed: () {
             setState(() {
               monthControl.addSchedule(context);
             });
           }).pOnly(bottom: 20.h),
      body: Column(
        children: [
          Obx(
            () =>
              Expanded(
                child: SfCalendar(
                  // monthCellBuilder:
                  //     (BuildContext buildContext, MonthCellDetails details) {
                  //   int today = DateTime.now().day;
                  //   return Container(
                  //     decoration: BoxDecoration(
                  //       //야간모드 당일 셀 color
                  //       color:  details.date.day == today?AppColors.darkGrey: Colors.transparent,
                  //       borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: Colors.transparent, width: 0.5)
                  //     ),
                  //       child: Padding(
                  //         padding: EdgeInsets.only(top:5.h,left: 20.h),
                  //         child: Text(
                  //         details.date.day.toString(),
                  //         style: TextStyle(color: details.date.day == today? context.appColors.textBadgeText: context.appColors.text,),
                  //         ),
                  //       )
                  //   );
                  // },
                  //viewNavigationMode: ViewNavigationMode.snap,
                  // showTodayButton: true,
                  view: CalendarView.month,
                  selectionDecoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    border: Border.all(color: Colors.transparent,
                        width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  todayHighlightColor: context.appColors.calendarMainColor, //당일 색상
                  cellBorderColor: Colors.transparent,
                  headerStyle: CalendarHeaderStyle(
                    textStyle: TextStyle(fontSize: bigFontSize + 5),
                  ),
                  onTap: (cp) {
                    monthControl.calendarTapped(context, cp);
                  },
                  onLongPress: (cpo){
                    monthControl.calendarLongTapped(context, cpo);
                  },
                  controller: _calendarController,
                  headerHeight: 50.h,
                  headerDateFormat: "MM",
                  dataSource:
                      ScheduleDataSource(monthControl.monthDataList.value),
                  monthViewSettings: MonthViewSettings(
                      agendaItemHeight: 45.h,//agenda 높이
                    numberOfWeeksInView: 4,
                      monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(
                              fontSize: smallFontSize + 2,
                              fontWeight: FontWeight.bold,
                              color: context.appColors.text,
                          ),
                          trailingDatesTextStyle: TextStyle(
                            fontSize: smallFontSize + 30,
                            fontWeight: FontWeight.bold,
                            color: context.appColors.text,
                          ),
                          leadingDatesTextStyle: TextStyle(
                            fontSize: smallFontSize + 3,
                            fontWeight: FontWeight.bold,
                          ),

                      ),
                      dayFormat: "E", //월요일 .. 화요일 ..
                      agendaStyle: AgendaStyle(
                        placeholderTextStyle: TextStyle(
                          color: context.appColors.text,
                        ),
                          appointmentTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: smallFontSize + 2,
                          ),
                          dayTextStyle: TextStyle(
                              color: AppColors.grey,
                              fontSize: normalFontSize,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                          ),
                          dateTextStyle: TextStyle(
                              color: AppColors.grey,
                              fontSize: bigFontSize,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)
                      ),
                      appointmentDisplayCount: 4,
                      showAgenda: true,
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                ),
              ),

          ),
          Height(30.h),
        ],
      ),
    );
  }


}
