import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';

import '../../common/constant/app_colors.dart';

class MemoContainer extends StatelessWidget with ScreenInit {
  String memoText;

  MemoContainer({super.key, required this.memoText});

  @override
  Widget build(BuildContext context) {
    screenInit(context);
    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(smallHeight),
            width: 320.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: AppColors.brightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: memoText.text.color(Colors.black).fontWeight(FontWeight.w300).make(),
          ),
        ),
      ],
    ).pOnly(right: 7.w);
  }
}
