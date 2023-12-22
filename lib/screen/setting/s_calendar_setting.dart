import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/dart/extension/context_extension.dart';
import 'package:today_my_calendar/screen/setting/w_switch.dart';

import '../../common/constant/constant_widget.dart';
import '../../common/data/preference/prefs.dart';
import '../../common/theme/theme_util.dart';
import '../../controller/setting_calendardata_controller.dart';

class CalendarSettingPage extends StatelessWidget {
  const CalendarSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingCalendarController _settingCalendarController =
        Get.put(SettingCalendarController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("캘린더 설정"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SettingSwitch(
            settingName: "다크 모드",
            isOn: context.isDarkMode,
            onChanged: (value) {
              ThemeUtil().toggleTheme(context);
            },
          ),
          Obx(() => SettingSwitch(
                settingName: "주 번호",
                isOn: Prefs.isWeekNum.get(),
                onChanged: (value) {
                  Prefs.isWeekNum.set(value);
                },
              )),
          Obx(() => SettingSwitch(
                settingName: "굵은 텍스트",
                isOn: Prefs.isDayFontWeight.get(),
                onChanged: (value) {
                  Prefs.isDayFontWeight.set(value);
                },
              )),
          SizedBox(height: bigHeight,),
          Obx(
            () => Column(
              children: [
                Text("안녕하세요 모코 캘린더입니다.",
                    style: TextStyle(
                        fontSize: Prefs.appointmentTextSize.get(),
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          SizedBox(height: bigHeight,),
          Obx(
            () => Card(
              color: context.appColors.settingListColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(smallWidth),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "이벤트 텍스트 크기".toString(),
                    style: const TextStyle(fontWeight: FontWeight.w300,color: Colors.black),
                  ),
                  const Spacer(),
                  Text(Prefs.appointmentTextSize.get().toInt().toString(),style: TextStyle(color: Colors.black),),
                  IconButton(
                    icon: const Icon(Icons.remove,color: Colors.black),
                    onPressed:
                        _settingCalendarController.appointmentTextSize.value >
                                11
                            ? () {
                                _settingCalendarController
                                    .appointmentTextSize.value--;
                                Prefs.appointmentTextSize.set(
                                    _settingCalendarController
                                        .appointmentTextSize.value);
                              }
                            : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add,color: Colors.black),
                    onPressed:
                        _settingCalendarController.appointmentTextSize.value <
                                18
                            ? () {
                                _settingCalendarController
                                    .appointmentTextSize.value++;
                                Prefs.appointmentTextSize.set(
                                    _settingCalendarController
                                        .appointmentTextSize.value);
                              }
                            : null,
                  ),
                ],
              ).paddingAll(smallHeight),
            ),
          ),
        ],
      ),
    );
  }
}
