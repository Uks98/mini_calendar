import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

import '../data/preference/prefs.dart';

class SettingListWithIcon extends StatelessWidget {
  IconData icon;
  String title;
  VoidCallback onTap;

  SettingListWithIcon({super.key,required this.icon,required this.title,required this.onTap});
  bool get _isLightModes => Prefs.isLightModes.get();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(left: normalWidth + 10,right: normalWidth + 10,bottom: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(smallWidth),
        ),
        color: _isLightModes ? AppColors.darkGrey:context.appColors.settingListColor,
        child: Row(
          children: [
          Icon(icon,size: bigFontSize,color: _isLightModes ? Colors.white : Colors.black),
          Width(normalWidth),
          title.text.size(bigFontSize).color(_isLightModes ? Colors.white : Colors.black).fontWeight(FontWeight.w300).make(),
          const Spacer(),
           Icon(EvaIcons.arrowIosForwardOutline,color: _isLightModes ? Colors.white : Colors.black,size: normalFontSize + 2,),
        ],).paddingAll(normalWidth),
      ),
    );
  }
}
