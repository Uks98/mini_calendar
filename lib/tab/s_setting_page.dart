import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today_my_calendar/common/common.dart';
import '../common/theme/theme_util.dart';
import '../common/widget/w_mode_switch.dart';
import '../controller/alarm_setting_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            "다크모드?".text.make(),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Switch(
                value: context.isDarkMode,
                onChanged: (value) {
                  ThemeUtil().toggleTheme(context);
                },
              ).pOnly(left: 20),
            ),
            ElevatedButton(onPressed: (){
              AlarmSettingController.notification.cancelAll();
              print("알람 전체 삭제");
            }, child: "예약된 알람 전체 삭제".text.make())
          ],
        ),
    );
  }
}
