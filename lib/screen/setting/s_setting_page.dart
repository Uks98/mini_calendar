import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/setting/s_calendar_setting.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/widget/setting_list_icon_text.dart';
import '../../controller/setting_calendardata_controller.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

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
            SettingListWithIcon(
              icon: Icons.chat_outlined,
              title: '피드백',
              onTap: () {
                sendEmail();
              }
            ),

          ],
        )
        );
  }

  void sendEmail() {
    String encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'rozyfactory@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': '모코캘린더에 대한 피드백을 남겨주세요.',
      }),
    );
    launch(emailLaunchUri.toString());
  }

}
