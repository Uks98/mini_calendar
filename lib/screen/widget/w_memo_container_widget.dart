import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';

import '../../common/constant/app_colors.dart';
import '../../common/theme/custom_theme.dart';

class MemoContainer extends StatelessWidget with ScreenInit {
  TextEditingController textEditingController;

  MemoContainer({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    screenInit(context);
    return Center(
      child: Container(
        width: 300.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: AppColors.brightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(

          style: const TextStyle(color: AppColors.darkGrey,fontWeight: FontWeight.w300),
          maxLines: 6,
          controller: textEditingController,
          decoration: const InputDecoration(
            hintText: '노트',
            hintStyle: TextStyle(fontWeight: FontWeight.w300),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}
