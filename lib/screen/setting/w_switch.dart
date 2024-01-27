

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/theme/color/mix_find_theme.dart';

import '../../common/constant/app_colors.dart';
import '../../common/constant/constant_widget.dart';
import '../../common/data/preference/prefs.dart';
import '../../common/widget/mixin/init_screen_size_utill.dart';

class SettingSwitch extends StatelessWidget with ScreenInit,ThemeDarkFind{
  final String settingName;
  final bool isOn;
  final ValueChanged<bool> onChanged;
  SettingSwitch({super.key,required this.settingName,required this.isOn,required this.onChanged});
  bool get _isLightModes =>  Prefs.isLightModes.get();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: normalWidth,right: normalWidth, bottom: 14.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(smallWidth),
      ),
      color: _isLightModes ? AppColors.darkGrey :context.appColors.settingListColor,
      child: Row(
        children: [
          Width(normalWidth),
          settingName.text.size(normalFontSize).color(_isLightModes ? Colors.white : Colors.black).fontWeight(FontWeight.w300).make(),
          const Spacer(),
          Switch(value: isOn, onChanged: onChanged,activeColor: Color(0xffBCA37F),),
        ],).paddingAll(smallHeight),
    );
  }
}
