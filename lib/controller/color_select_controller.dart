

import 'dart:ui';

import 'package:get/get.dart';

class ColorSelectController extends GetxController{
  RxInt selectIndex = 0.obs;
  RxMap<Color,String> colorList = <Color,String>{
    const Color(0xffFFAD84) : "Hit Pink",
    const Color(0xffFFC47E) : "Macaroni and Cheese",
    const Color(0xff7071E8) : "Cornflower Blue",
    const Color(0xffCD5C08) : "Christine",
    const Color(0xff1640D6) : "Blue Ribbon",
    const Color(0xff000000) : "classic black",
    const Color(0xff65451F) : "Kumera"}.obs;
}