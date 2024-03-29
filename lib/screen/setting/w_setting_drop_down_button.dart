import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_calendar/common/common.dart';

import '../../common/constant/app_colors.dart';
import '../../common/constant/constant_widget.dart';
import '../../common/widget/repeat_tile/repeat_dropdown.dart';

class SettingDropDownWidget extends StatelessWidget {
  const SettingDropDownWidget({
    super.key,
    required this.isLightModes,
  });

  final bool isLightModes;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isLightModes ? AppColors.darkGrey :context.appColors.settingListColor,
      margin: EdgeInsets.only(left: normalWidth,right: normalWidth, bottom: 14.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(smallWidth),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left:normalWidth + 5.w),
            child: const Text("시작 요일",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
            ),
          ),
          const SimpleDropdown(),
        ],
      ),
    );
  }
}