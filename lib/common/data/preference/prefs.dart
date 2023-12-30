
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/data/preference/item/rx_preference_item.dart';

import '../../../controller/setting_calendardata_controller.dart';
import '../../theme/custom_theme.dart';
import 'item/nullable_preference_item.dart';

class Prefs with SettingCalendarControllerMix{
 final SettingCalendarController _settingCalendarController = Get.put(SettingCalendarController());
  SettingCalendarController get x => _settingCalendarController;
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');
  static final isWeekNum = RxPreferenceItem<bool,RxBool>("isWeekNum", false);
  static final isDayFontWeight = RxPreferenceItem<bool,RxBool>("isDayFontWeight", false);
  static final appointmentTextSize = RxPreferenceItem<double,RxDouble>("appointmentTextSize", 13.0); //controller 초기값 오류로 임의 매직 넘버 부여
  static final isLateDayFontGrey = RxPreferenceItem<bool,RxBool>("isLateDayFontGrey", false); //controller 초기값 오류로 임의 매직 넘버 부여
}
