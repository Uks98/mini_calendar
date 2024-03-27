
import 'package:get/get.dart';

class RepeatController extends GetxController{
  RxString repeatText = "".obs;
  RxString repeatEndText = "".obs;
  RxInt repeatIndex = 0.obs;


}


mixin class RepeatControllerMixin {
  late RepeatController repeatController = Get.put(RepeatController());
}
