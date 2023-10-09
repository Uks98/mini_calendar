
import 'package:get/get.dart';

import '../screen/calendar/calendar_data/d_schedule_data.dart';

class MonthControl extends GetxController{
  RxList<Schedule> monthDataList = <Schedule>[].obs;

  void addItem(Schedule schedule) {
    monthDataList.add(schedule);
    refresh();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

mixin class MonthControllerMix{
  late MonthControl monthControl = Get.put(MonthControl());
}