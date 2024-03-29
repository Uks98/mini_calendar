import 'package:app_settings/app_settings.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/widget/mixin/payment_mixin.dart';
import 'package:today_my_calendar/screen/setting/s_calendar_setting.dart';
import 'package:today_my_calendar/screen/setting/s_font_change_screen.dart';
import 'package:today_my_calendar/tab/s_calendar_day_page.dart';
import 'package:today_my_calendar/tab/s_calendar_month_page.dart';
import 'package:turn_page_transition/turn_page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/widget/setting_list_icon_text.dart';
import '../../tab/s_main_screen.dart';

class SettingPage extends StatelessWidget with PaymentShowSheet{
   SettingPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "설정".text.size(normalFontSize).make(),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: bigHeight,
            ),
            SettingListWithIcon(
              icon: EvaIcons.calendarOutline,
              title: '캘린더 설정',
              onTap: () => Get.to(
                CalendarSettingPage(),
              ),
            ),
            SettingListWithIcon(
              icon: EvaIcons.brushOutline,
              title: '서체',
              onTap: () => Get.to(
                FontChangeScreen(),
              ),
            ),
            SettingListWithIcon(
              icon: EvaIcons.giftOutline,
              title: '프리미엄 결제',
              onTap: () => showPaymentSheet(context)
            ),
            SettingListWithIcon(
                icon: EvaIcons.optionsOutline,
                title: '알림 설정',
                onTap: () => AppSettings.openAppSettings(type: AppSettingsType.notification),
            ),
            SettingListWithIcon(
              icon: EvaIcons.mapOutline,
              title: '위치 설정',
              onTap: () => AppSettings.openAppSettings(type: AppSettingsType.location),
            ),
            SettingListWithIcon(
                icon: EvaIcons.infoOutline,
                title: '피드백',
                onTap: () => _sendEmail()
            ),
            // ElevatedButton(onPressed: (){
            //   Get.to(PageViewPage());
            // }, child: "a".text.make())
          ],
        )
        );
  }

  void _sendEmail() {
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

class PageViewPage extends StatelessWidget {
   PageViewPage({super.key});
  @override
  List<Widget> list = [MainScreen(),CalendarDayPage()];
  Widget build(BuildContext context) {
    final controller = TurnPageController();
    return Scaffold(
      body: TurnPageView.builder(
        controller: controller,
        itemCount: 2,
        itemBuilder: (context, index) => list[index],
        //overleafColorBuilder: (index) => colors[index],
        animationTransitionPoint: 0.5,
      ),
    );
  }
}