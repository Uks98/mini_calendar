import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/data/preference/prefs.dart';
import 'package:today_my_calendar/screen/setting/w_switch.dart';
import '../../common/theme/theme_util.dart';
import '../../controller/setting_calendardata_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
  final SettingCalendarController _settingCalendarController = Get.put(SettingCalendarController());
    return Scaffold(
        body: ListView(
          children: [
        SettingSwitch(
          settingName: "다크 모드",
          isOn: context.isDarkMode,
          onChanged: (value) {
            ThemeUtil().toggleTheme(context);
          },
        ),
           Obx(() =>  SettingSwitch(
              settingName: "주 번호",
              isOn: Prefs.isWeekNum.get(),
              onChanged: (value) {
                Prefs.isWeekNum.set(value);
              },
            )),
            Obx(() =>  SettingSwitch(
              settingName: "굵은 텍스트",
              isOn: Prefs.isDayFontWeight.get(),
              onChanged: (value) {
                Prefs.isDayFontWeight.set(value);
              },
            )),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    _settingCalendarController.appointmentTextSize.value--;
                    Prefs.appointmentTextSize.set(_settingCalendarController.appointmentTextSize.value);
                  },
                ),
                Text(Prefs.appointmentTextSize.get().toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _settingCalendarController.appointmentTextSize.value++;
                    Prefs.appointmentTextSize.set(_settingCalendarController.appointmentTextSize.value);
                  },
                ),
              ],
            ),),
            // MouseRegion(
            //   cursor: SystemMouseCursors.click,
            //   child: Switch(
            //     value: context.isDarkMode,
            //     onChanged: (value) {
            //       ThemeUtil().toggleTheme(context);
            //     },
            //   ).pOnly(left: 20),
            // ),
          ],
        )
        // Column(
        //   children: [
        //     "다크모드?".text.make(),
        //     MouseRegion(
        //       cursor: SystemMouseCursors.click,
        //       child: Switch(
        //         value: context.isDarkMode,
        //         onChanged: (value) {
        //           ThemeUtil().toggleTheme(context);
        //         },
        //       ).pOnly(left: 20),
        //     ),
        //     ElevatedButton(onPressed: (){
        //       AlarmSettingController.notification.cancelAll();
        //       print("알람 전체 삭제");
        //     }, child: "예약된 알람 전체 삭제".text.make())
        //   ],
        // ),
    );
  }
}
