

import 'package:get/get.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

class SettingCalendarController extends GetxController{
  RxDouble appointmentTextSize = 13.0.obs;



}
mixin class SettingCalendarControllerMix {
  late SettingCalendarController settingCalendarController = Get.put(SettingCalendarController());
}