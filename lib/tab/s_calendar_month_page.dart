import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/theme/color/mix_find_theme.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
import 'package:today_my_calendar/controller/date_picker_controller.dart';
import 'package:today_my_calendar/screen/setting/s_setting_page.dart';
import '../common/data/preference/prefs.dart';
import '../controller/alarm_setting_controller.dart';
import '../controller/month_data_controller.dart';
import '../main.dart';
import '../screen/calendar/calendar_data/schecule_data_source.dart';

class CalendarMonthPage extends StatefulWidget {
  const CalendarMonthPage({
    super.key,
  });

  @override
  State<CalendarMonthPage> createState() => _CalendarMonthPageState();
}

class _CalendarMonthPageState extends State<CalendarMonthPage>
    with ScreenInit, MonthControllerMix,ThemeDarkFind,DatePickerSetMix {
  final CalendarController _calendarController = CalendarController();
  final AlarmSettingController alarmController = Get.put(AlarmSettingController());

  final _floatingKey =
  GlobalKey<ExpandableFabState>(); // floating action button global key

  Color get changeSmallFloatingColor => !isLightMode
      ? context.appColors.calendarMainColor
      : context.appColors.floatingIconColor;

  Color get changeSmallFloatingIconColor => isLightMode
      ? context.appColors.calendarMainColor
      : context.appColors.floatingIconColor;
  String month = "";

 bool get isSameDayFontGrey => DateTime.now().day != monthControl.calendarSameDay.value;

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
      // 리팩토링 키패드 오류 문제 해결중
      floatingActionButton: ExpandableFab(
        overlayStyle: ExpandableFabOverlayStyle(blur:  10.0),
        openButtonBuilder: buildRotateFloatingActionButtonBuilder(context, const Icon(EvaIcons.plus)),
        closeButtonBuilder: buildRotateFloatingActionButtonBuilder(context, const Icon(EvaIcons.close)),
        type: ExpandableFabType.up,
        distance: 55.w,
        key: _floatingKey,
        children: [
          FloatingActionButton.small(
            heroTag: "tsss",
            backgroundColor: changeSmallFloatingColor,
            child: Icon(
              Icons.edit,
              color: changeSmallFloatingIconColor,
            ),
            onPressed: () => monthControl.addSchedule(context,pickerSetController.startSelectedTime.value,pickerSetController.lastSelectedTime.value),
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
      ).pOnly(bottom: 30.h),
      body: Column(
        children: [
          Obx(() => Flexible(
            key: GlobalKey(),
              child: SfCalendar(

                showTodayButton: true,
                weekNumberStyle: WeekNumberStyle(textStyle: TextStyle(fontWeight: FontWeight.w300,fontSize: smallFontSize +1,)),
                showWeekNumber: Prefs.isWeekNum.get(), //주번호
                viewHeaderHeight: 63.h,
                todayTextStyle: const TextStyle(color: Colors.white),
                view: CalendarView.month,
                //border
                selectionDecoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  border: Border.all(color: Colors.transparent, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                todayHighlightColor: !isLightMode
                    ? context.appColors.calendarMainColor
                    : context.appColors.todaySelectedColor,
                //셀 보더
                cellBorderColor: Prefs.isCellBorder.get() ? Colors.grey[500] : Colors.transparent,

                headerStyle: CalendarHeaderStyle(
                  textStyle: TextStyle(fontSize: bigFontSize + 5),
                ),
                onTap: (cp) async{
                  pickerSetController.startSelectedTime.value = cp.date!;
                  pickerSetController.lastSelectedTime.value = cp.date!;
                    monthControl.calendarSameDay.value = cp.date!.day;
                    monthControl.calendarTapped(context, cp);
                  final List<PendingNotificationRequest> pendingNotificationRequests = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
                  for(final i in pendingNotificationRequests){
                  print(" 보류중인 알림 ${i.payload}");
                  }
                  print(pendingNotificationRequests);

                  //await flutterLocalNotificationsPlugin.cancelAll();
                },
                onLongPress: (cpo) {
                  showMessageDialog(context, cpo);
                },
                controller: _calendarController,
                //header
                headerDateFormat: "MMMM",
                headerHeight: 50.h,
                ///일정 데이터
                dataSource: ScheduleDataSource(monthControl.monthDataList.value),
                monthViewSettings: MonthViewSettings(

                    agendaItemHeight: 45.h,
                    //agenda 높이
                    numberOfWeeksInView: 4,
                    monthCellStyle: MonthCellStyle(
                      textStyle: TextStyle(
                        fontSize: smallFontSize + 2,
                        //달력 dayStyle 굵은 텍스트
                        fontWeight: Prefs.isDayFontWeight.get() ?FontWeight.w300:FontWeight.bold ,
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
                          color: Prefs.isLateDayFontGrey.get() && isSameDayFontGrey ? const Color(0xffA9A9A9) : Colors.white,
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
                            fontStyle: FontStyle.normal),),
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