import 'package:flutter/cupertino.dart';
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
import '../common/theme/custom_theme.dart';
import '../common/widget/w_util_floating_btn.dart';
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
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: UtilFloating(
        buildContext: context,
        distance: 55.w,
        goToAddPage: () {
              monthControl.addSchedule(context);
        },
        goToSetPage: () {
          Get.to(SettingPage());
        },
      ).buildExpandableFab(context).pOnly(bottom: 10.h),
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
                monthControl.calendarTapped(context, cp);
              },
              onLongPress: (cpo){
                  showMessageDialog(context,cpo);
              },
              viewHeaderHeight: bigHeight + 60,
              todayHighlightColor: context.appColors.calendarMainColor, //당일 색상
              showTodayButton: true,
              headerDateFormat: "MM",
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
