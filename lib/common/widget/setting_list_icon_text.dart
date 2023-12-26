import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

class SettingListWithIcon extends StatelessWidget {
  IconData icon;
  String title;
  VoidCallback onTap;
  SettingListWithIcon({super.key,required this.icon,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(left: normalWidth + 10,right: normalWidth + 10,bottom: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(smallWidth),
        ),
        color: context.appColors.settingListColor,
        child: Row(
          children: [
          Icon(icon,size: bigFontSize,color: Colors.black),
          Width(normalWidth),
          title.text.size(bigFontSize).color(Colors.black).fontWeight(FontWeight.w300).make(),
          const Spacer(),
           Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,size: normalFontSize + 2,),
        ],).paddingAll(normalWidth),
      ),
    );
  }
}
