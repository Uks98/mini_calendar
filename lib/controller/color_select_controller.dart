

import 'dart:ui';

import 'package:get/get.dart';

class ColorSelectController extends GetxController{
  RxInt selectIndex = 0.obs;
  RxList<Color> colorList = <Color>[Color(0xff86A789),Color(0xffF4BF96),Color(0xffCE5A67),Color(0xffCD5C08)].obs;
}