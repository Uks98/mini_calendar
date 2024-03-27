import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/widget/repeat_tile/repeat_dropdown.dart';
import 'package:today_my_calendar/controller/repeat_controller.dart';

import '../../constant/constant_widget.dart';

class RepeatEndTile extends StatefulWidget {
  const RepeatEndTile({super.key});

  @override
  State<RepeatEndTile> createState() => _RepeatEndTileState();
}
class _RepeatEndTileState extends State<RepeatEndTile> with RepeatControllerMixin {
  bool isShowDate = false;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        GestureDetector(
          onTap: (){
            setState(() {
              isShowDate = !isShowDate;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "반복 종료"
                  .text
                  .size(normalFontSize)
                  .fontWeight(
                FontWeight.w300,
              ).make().paddingOnly(left: 5.h),
              SizedBox(
                width: smallWidth,
              ),
            ],
          ),
        ),
        isShowDate == false ? SizedBox() : SizedBox(width : 300.w,height:250.h,child: SfDateRangePicker(
          onSelectionChanged: (arg){
            final time = DateFormat("yyyyMMdd183000").format(DateTime.parse(arg.value.toString()));
            final timeAddPlus = "${time}Z";
            repeatController.repeatEndText.value = timeAddPlus;
                print(timeAddPlus);
          },
        )),
      ],
    );
  }
}
