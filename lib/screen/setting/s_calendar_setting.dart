import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/dart/extension/context_extension.dart';
import 'package:today_my_calendar/common/widget/mixin/payment_mixin.dart';
import 'package:today_my_calendar/controller/month_data_controller.dart';
import 'package:today_my_calendar/screen/setting/w_switch.dart';

import '../../common/constant/app_colors.dart';
import '../../common/constant/constant_widget.dart';
import '../../common/data/preference/prefs.dart';
import '../../common/theme/theme_util.dart';
import '../../common/widget/mixin/init_screen_size_utill.dart';
import '../../controller/setting_calendardata_controller.dart';

class CalendarSettingPage extends StatelessWidget with ScreenInit,PaymentShowSheet,MonthControllerMix{
  CalendarSettingPage({super.key});
  bool get isLightModes =>  Prefs.isLightModes.get();
  @override
  Widget build(BuildContext context) {
    final SettingCalendarController settingCalendarController = Get.put(SettingCalendarController());
    return Scaffold(
      appBar: AppBar(
        title:  Text("캘린더 설정",style: TextStyle(fontSize: normalFontSize),),
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
                if(Prefs.isPurchaseApp.get() == false){
                  showPaymentSheet(context);
                }else{
                  Prefs.isWeekNum.set(value);
                }
              }
          )),
          Obx(() => SettingSwitch(
            settingName: "가는 텍스트",
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
              margin: EdgeInsets.only(left: normalWidth,right: normalWidth,bottom: 14.h),
              color: context.appColors.settingListColor , //preference obx 충돌
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
                    settingCalendarController.appointmentTextSize.value >
                        11
                        ? () {
                      settingCalendarController
                          .appointmentTextSize.value--;
                      Prefs.appointmentTextSize.set(
                          settingCalendarController
                              .appointmentTextSize.value);
                    }
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add,color: Colors.black),
                    onPressed:
                    settingCalendarController.appointmentTextSize.value <
                        18
                        ? () {
                      settingCalendarController
                          .appointmentTextSize.value++;
                      Prefs.appointmentTextSize.set(
                          settingCalendarController
                              .appointmentTextSize.value);
                    }
                        : null,
                  ),
                ],
              ).paddingAll(smallHeight),
            ),
          ),
          Obx(
                () => Card(
              margin: EdgeInsets.only(left: normalWidth,right: normalWidth,bottom: 14.h),
              color: context.appColors.settingListColor , //preference obx 충돌
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(smallWidth),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "캘린더 일정 텍스트 크기".toString(),
                    style: const TextStyle(fontWeight: FontWeight.w300,color: Colors.black),
                  ),
                  const Spacer(),
                  Text(Prefs.calendarAppointmentTextSize.get().toInt().toString(),style: TextStyle(color: Colors.black),),
                  IconButton(
                    icon: const Icon(Icons.remove,color: Colors.black),
                    onPressed:
                    settingCalendarController.calendarAppointmentText.value >
                        8
                        ? () {
                      settingCalendarController
                          .calendarAppointmentText.value--;
                      Prefs.calendarAppointmentTextSize.set(
                          settingCalendarController
                              .calendarAppointmentText.value);
                    }
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add,color: Colors.black),
                    onPressed:
                    settingCalendarController.calendarAppointmentText.value <
                        11
                        ? () {
                      settingCalendarController
                          .calendarAppointmentText.value++;
                      Prefs.calendarAppointmentTextSize.set(
                          settingCalendarController
                              .calendarAppointmentText.value);
                    }
                        : null,
                  ),
                ],
              ).paddingAll(smallHeight),
            ),
          ),
          Obx(() => SettingSwitch(
            settingName: "지난 이벤트 흐리게 표시",
            isOn: Prefs.isLateDayFontGrey.get(),
            onChanged: (value) {
              Prefs.isLateDayFontGrey.set(value);
            },
          )),
          Obx(() => SettingSwitch(
            settingName: "날짜 테두리 표시",
            isOn: Prefs.isCellBorder.get(),
            onChanged: (value) {
              Prefs.isCellBorder.set(value);
            },
          )),
          Obx(() => SettingSwitch(
            settingName: "기념일 정보 켜기",
            isOn: Prefs.isEventDay.get(),
            onChanged: (value) {
              Prefs.isEventDay.set(value);
              monthControl.isOnFunction();
            },
          )),
        ],
      ),
    );
  }
}