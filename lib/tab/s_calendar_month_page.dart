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
import '../controller/alarm_setting_controller.dart';
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.appColors.calendarMainColor,
          child: Icon(Icons.add,color: context.appColors.floatingIconColor,),
          onPressed: () {
            setState(() {
              monthControl.addSchedule(context);
              print("타임 ${DateTimeComponents.time}");
            });
          }).pOnly(bottom: 20.h),
      body: Column(
        children: [
          Obx(
            () =>
              Expanded(
                child: SfCalendar(
                  selectionDecoration: BoxDecoration(
                    color: context.appColors.calendarMainColor.withOpacity(0.1),
                    border: Border.all(color: context.appColors.calendarMainColor,
                        width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  todayHighlightColor: context.appColors.calendarMainColor, //당일 색상
                  cellBorderColor: Colors.transparent,
                  headerStyle: CalendarHeaderStyle(
                    textStyle: TextStyle(fontSize: bigFontSize + 5),
                  ),
                  onTap: (cp) {
                    calendarTapped(context, cp);
                    setState(() {});
                  },
                  onLongPress: (cpo){
                    setState(() {
                    calendarLongTapped(context,cpo);
                    });
                  },
                  controller: _calendarController,
                  headerHeight: 50.h,
                  headerDateFormat: "MM",
                  view: CalendarView.month,
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
                          todayBackgroundColor: AppColors.darkGrey, //야간모드 당일 셀 color
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

  void calendarTapped(
      BuildContext context, CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      Schedule event = calendarTapDetails.appointments![0];
      monthControl.editSchedule(event, context);
    }
  }
  void calendarLongTapped(
      BuildContext context, CalendarLongPressDetails calendarLongPressDetails){
    if (calendarLongPressDetails.targetElement == CalendarElement.appointment) {
      Schedule event = calendarLongPressDetails.appointments![0];
      monthControl.deleteSchedule(event);
    }
  }
}
