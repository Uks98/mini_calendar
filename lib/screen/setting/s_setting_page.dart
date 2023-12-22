import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/data/preference/prefs.dart';
import 'package:today_my_calendar/screen/setting/s_calendar_setting.dart';
import '../../common/widget/setting_list_icon_text.dart';
import '../../controller/setting_calendardata_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingCalendarController _settingCalendarController =
        Get.put(SettingCalendarController());
    return Scaffold(
        appBar: AppBar(
          title: Text("설정"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: bigHeight,
            ),
            SettingListWithIcon(
              icon: Icons.calendar_month_outlined,
              title: '캘린더 설정',
              onTap: () => Get.to(
                CalendarSettingPage(),
              ),
            ),

          ],
        )
        );
  }
}
