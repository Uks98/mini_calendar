
import 'package:get/get.dart';
import 'package:today_my_calendar/common/data/preference/item/rx_preference_item.dart';

import '../../../controller/setting_calendardata_controller.dart';
import '../../theme/custom_theme.dart';
import 'item/nullable_preference_item.dart';

class Prefs with SettingCalendarControllerMix{
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');
  static final isWeekNum = RxPreferenceItem<bool,RxBool>("isWeekNum", false);
  static final isDayFontWeight = RxPreferenceItem<bool,RxBool>("isDayFontWeight", false);
  static final appointmentTextSize = RxPreferenceItem<double,RxDouble>("appointmentTextSize", 13.0); //controller 초기값 오류로 임의 매직 넘버 부여
  static final isLateDayFontGrey = RxPreferenceItem<bool,RxBool>("isLateDayFontGrey", false);

  static final isCellBorder = RxPreferenceItem<bool,RxBool>("isCellBorder", false); //달력 셀 테두리

  static final isLightModes = RxPreferenceItem<bool,RxBool>("isLightModes", false); //controller 초기값 오류로 임의 매직 넘버 부여

 static final isTest = RxPreferenceItem<bool,RxBool>("isTest", false); //controller 초기값 오류로 임의 매직 넘버 부여

 static final isPurchaseApp = RxPreferenceItem<bool,RxBool>("isPurchaseApp", false); // 배너 광고 제거 결제 했는지 유무 판단 boolean

 static final currentFont = RxPreferenceItem<String,RxString>("currentFont", "dream"); // 현재 폰트를 변경하고 저장합니다.

}
