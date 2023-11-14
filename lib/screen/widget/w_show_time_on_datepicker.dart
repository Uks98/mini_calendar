import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_calendar/common/common.dart';

import '../../common/constant/constant_widget.dart';
import '../../common/widget/w_tap.dart';

class ShowTimeOnDatePicker{
  static void onDatePicker(int timeHour,int timeMinute,bool isShow,void Function() changeTime(date),VoidCallback changeShow){
    Tap(
      onTap: changeShow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "10월 1일 (일)".text.size(normalFontSize).make(),
          "${timeHour} : ${timeMinute}".text.bold.size(bigFontSize).make(),
          if (isShow)
            SizedBox(
              width: 350.h,
              height: 100.w,
              child: Center(
                child: CupertinoDatePicker(
                  dateOrder: DatePickerDateOrder.ymd,
                  minimumYear: 2010,
                  maximumYear: DateTime.now().year,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (date)=>changeTime(date),
                  mode: CupertinoDatePickerMode.time,
                ),
              ),
            ),
        ],
      ),
    );
  }
}