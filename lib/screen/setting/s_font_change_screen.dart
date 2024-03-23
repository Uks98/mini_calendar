import 'package:app_settings/app_settings.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/setting/s_calendar_setting.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/data/preference/prefs.dart';
import '../../common/widget/setting_list_icon_text.dart';

class FontChangeScreen extends StatefulWidget {
  const FontChangeScreen({super.key});

  @override
  State<FontChangeScreen> createState() => _FontChangeScreenState();
}

class _FontChangeScreenState extends State<FontChangeScreen> {
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
              icon: EvaIcons.brushOutline,
              title: '드림 폰트 입니다 012345678 Hello',
              fontFamily: "dream",
              onTap: (){

                Prefs.currentFont.set("dream");
                setState(() {});

              }
            ),
            SettingListWithIcon(
              icon: EvaIcons.brushOutline,
              title: '부크크 폰트 입니다 012345678 Hello',
              fontFamily: "bukk",
              onTap: () async {
                await Prefs.currentFont.set("bukk");
                setState(() {

                });
              }),
          ],
        )
    );
  }
}
