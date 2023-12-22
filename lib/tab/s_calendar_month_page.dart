import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/theme/color/mix_find_theme.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
import 'package:today_my_calendar/controller/setting_calendardata_controller.dart';
import 'package:today_my_calendar/screen/setting/s_setting_page.dart';
import '../common/data/preference/prefs.dart';
import '../controller/alarm_setting_controller.dart';
import '../controller/month_data_controller.dart';
import '../screen/calendar/calendar_data/schecule_data_source.dart';

class CalendarMonthPage extends StatefulWidget {
  const CalendarMonthPage({
    super.key,
  });

  @override
  State<CalendarMonthPage> createState() => _CalendarMonthPageState();
}

class _CalendarMonthPageState extends State<CalendarMonthPage>
    with ScreenInit, MonthControllerMix,ThemeDarkFind {
  final CalendarController _calendarController = CalendarController();
  final AlarmSettingController alarmController = Get.put(AlarmSettingController());
  final SettingCalendarController _settingCalendarController = Get.put(SettingCalendarController());

  final _floatingKey =
      GlobalKey<ExpandableFabState>(); // floating action button global key

  Color get changeSmallFloatingColor => !isLightMode
      ? context.appColors.calendarMainColor
      : context.appColors.floatingIconColor;

  Color get changeSmallFloatingIconColor => isLightMode
      ? context.appColors.calendarMainColor
      : context.appColors.floatingIconColor;
  String month = "";


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   findDarkMode(context);
    screenInit(context);
    return Scaffold(
      key: GlobalKey<_CalendarMonthPageState>(),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        overlayStyle: ExpandableFabOverlayStyle(blur:  10.0),
        openButtonBuilder: buildRotateFloatingActionButtonBuilder(context, const Icon(Icons.add)),
        closeButtonBuilder: buildRotateFloatingActionButtonBuilder(context, const Icon(Icons.close)),
        type: ExpandableFabType.up,
        distance: 55.w,
        key: _floatingKey,
        children: [
          FloatingActionButton.small(
            heroTag: "b",
            backgroundColor: changeSmallFloatingColor,
            child: Icon(
              Icons.edit,
              color: changeSmallFloatingIconColor,
            ),
            onPressed: () {
              setState(() {
                monthControl.addSchedule(context);
              });
            },
          ),
          FloatingActionButton.small(
            heroTag: "c",
            backgroundColor: changeSmallFloatingColor,
            child: Icon(
              Icons.settings,
              color: changeSmallFloatingIconColor,
            ),
            onPressed: () {
              Get.to(const SettingPage());
            },
          ),
        ],
      ).pOnly(bottom: 10.h),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: SfCalendar(
                showTodayButton: true,
                weekNumberStyle: const WeekNumberStyle(textStyle: TextStyle(fontWeight: FontWeight.w300,fontSize: 11)),
                showWeekNumber: Prefs.isWeekNum.get(), //주번호
                viewHeaderHeight: 63.h,
                todayTextStyle: const TextStyle(color: Colors.white),
                view: CalendarView.month,
                selectionDecoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  border: Border.all(color: Colors.transparent, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                todayHighlightColor: !isLightMode
                    ? context.appColors.calendarMainColor
                    : context.appColors.todaySelectedColor,
                //당일 색상
                cellBorderColor: Colors.transparent,
                headerStyle: CalendarHeaderStyle(
                  textStyle: TextStyle(fontSize: bigFontSize + 5),
                ),
                onTap: (cp) {
                  monthControl.calendarTapped(context, cp);
                },
                onLongPress: (cpo) {
                  showMessageDialog(context, cpo);
                },
                controller: _calendarController,
                headerHeight: 50.h,
                headerDateFormat: "MM",
                dataSource:
                    ScheduleDataSource(monthControl.monthDataList.value),
                monthViewSettings: MonthViewSettings(
                    agendaItemHeight: 45.h,
                    //agenda 높이
                    numberOfWeeksInView: 4,
                    monthCellStyle: MonthCellStyle(
                      textStyle: TextStyle(
                        fontSize: smallFontSize + 2,
                        //달력 dayStyle
                        fontWeight: Prefs.isDayFontWeight.get() ? FontWeight.bold : FontWeight.w300,
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
                        color: context.appColors.text,
                      ),
                    ),
                    dayFormat: "E",
                    //월요일 .. 화요일 ..
                    agendaStyle: AgendaStyle(
                        placeholderTextStyle: TextStyle(
                          color: context.appColors.text,
                        ),
                        appointmentTextStyle: TextStyle(
                          color: Colors.white,
                          //일정 폰트!!
                          fontSize:  Prefs.appointmentTextSize.get(),
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
                            fontStyle: FontStyle.normal)),
                    appointmentDisplayCount: 3,
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

  RotateFloatingActionButtonBuilder buildRotateFloatingActionButtonBuilder(
      BuildContext context, Icon icon) {
    return RotateFloatingActionButtonBuilder(
      //heroTag: "f",
      child: icon,
      fabSize: ExpandableFabSize.regular,
      foregroundColor: context.appColors.floatingIconColor,
      backgroundColor: context.appColors.calendarMainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(normalHeight),
      ),
    );
  }
}
