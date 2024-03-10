import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/controller/month_data_controller.dart';
import 'package:today_my_calendar/screen/setting/s_setting_page.dart';

import '../common/constant/constant_widget.dart';
import '../common/data/preference/prefs.dart';
import '../common/theme/color/mix_find_theme.dart';
import '../common/widget/w_util_floating_btn.dart';
import '../controller/date_picker_controller.dart';
import '../screen/calendar/calendar_data/schecule_data_source.dart';

class CalendarDayPage extends StatefulWidget {
  const CalendarDayPage({super.key});

  @override
  State<CalendarDayPage> createState() => _CalendarDayPageState();
}

class _CalendarDayPageState extends State<CalendarDayPage> with MonthControllerMix,ThemeDarkFind,DatePickerSetMix{
  bool get isSameDayFontGrey => DateTime.now().day != monthControl.calendarSameDay.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: UtilFloating(
        buildContext: context,
        distance: 55.h,
        goToAddPage: () =>
          monthControl.addSchedule(context,pickerSetController.startSelectedTime.value,pickerSetController.lastSelectedTime.value),
        goToSetPage: () {
          Get.to(const SettingPage());
        },
      ).buildExpandableFab(context).pOnly(bottom: 20.h,right: 10.w),
      body: Obx(() =>Column(
        children: [
          Expanded(
            child: SfCalendar(

              appointmentTextStyle: TextStyle(color: Colors.white,fontSize: Prefs.appointmentTextSize.get()),
              todayTextStyle: const TextStyle(color: Colors.white),
              scheduleViewSettings: const ScheduleViewSettings(
                dayHeaderSettings: DayHeaderSettings(
                  dayFormat: "EEE"
                )
              ),
              allowedViews: const <CalendarView>
              [
                CalendarView.day,
                CalendarView.week,
                CalendarView.timelineWeek,
                CalendarView.timelineDay,
              ],
              onTap: (cp) {
                pickerSetController.startSelectedTime.value = cp.date!;
                pickerSetController.lastSelectedTime.value = cp.date!;
                monthControl.calendarTapped(context, cp);
              },
              onLongPress: (cpo){
                  showMessageDialog(context,cpo);
              },
              viewHeaderHeight: bigHeight + 60,
              todayHighlightColor: !isLightMode
                  ? context.appColors.todaySelectedColor //당일 색상
                  : context.appColors.calendarMainColor,
              showTodayButton: true,
              headerDateFormat: "MMM",
                headerStyle: CalendarHeaderStyle(
                  textStyle: TextStyle(fontSize:bigFontSize + 5),
                ),
                allowAppointmentResize: true,
             dataSource: ScheduleDataSource(monthControl.monthDataList.value),
              view: CalendarView.day,
                ),
          ),
          Height(bigHeight + 30)
        ],
      ),
      ),
    );
  }
}
