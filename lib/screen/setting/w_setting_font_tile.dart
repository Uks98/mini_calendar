import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';

import '../../common/constant/app_colors.dart';
import '../../common/constant/constant_widget.dart';
import '../../common/data/preference/prefs.dart';
import '../../common/widget/w_height_and_width.dart';

class SettingFontTile extends StatelessWidget {
  String title;
  IconData icon;
  IconData checkIcon;
  String? fontFamily;
  VoidCallback callBack;
  SettingFontTile({super.key,required this.title,required this.icon,required this.checkIcon,required this.fontFamily,required this.callBack});

  bool get _isLightModes => Prefs.isLightModes.get();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: callBack,
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
            title.text.size(bigFontSize).color(_isLightModes ? Colors.white : Colors.black).fontWeight(FontWeight.w300).fontFamily(fontFamily ?? "dream").make(),
            const Spacer(),
             Icon(checkIcon,color: _isLightModes ? Colors.white : Colors.black,size: normalFontSize + 2,)
          ],).paddingAll(normalWidth),
      ),
    );
  }
}
