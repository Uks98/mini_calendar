

import 'package:get/get.dart';

class SettingCalendarController extends GetxController{
  RxDouble appointmentTextSize = 13.0.obs;
  RxDouble calendarAppointmentText = 8.0.obs;



}
mixin class SettingCalendarControllerMix {
  late SettingCalendarController settingCalendarController = Get.put(SettingCalendarController());
}