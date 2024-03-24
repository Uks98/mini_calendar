import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


mixin class ScreenInit{
  ///screen utill padding값 사용시 init함수를 불러와 초기화 시켜줘야 합니다.
  ///반복되는 코드라 mixin작업했습니다.
  void screenInit(BuildContext context){
    ScreenUtil.init(context);
  }
  String returnToMonDay(int fromMonth, int toMonth, int fromDay, int toDay,
      int hour, int minute) {
    if (fromMonth == toMonth && fromDay == toDay) {
      return "${hour < 12 ? "오전" : "오후"} $hour시 $minute분";
    }
    return "$toMonth월 $toDay일 ${hour < 12 ? "오전" : "오후"} $hour시 $minute분";
  }
}
