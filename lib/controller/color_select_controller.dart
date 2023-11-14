

import 'dart:ui';

import 'package:get/get.dart';

class ColorSelectController extends GetxController{
  RxInt selectIndex = 0.obs;
  RxList<Color> colorList = <Color>[const Color(0xff89B9AD),const Color(0xffF4BF96),const Color(0xffCE5A67),const Color(0xffCD5C08),
    const Color(0xff1640D6),const Color(0xff000000),const Color(0xff65451F)].obs;
}