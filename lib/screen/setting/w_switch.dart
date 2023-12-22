

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';

import '../../common/constant/constant_widget.dart';

class SettingSwitch extends StatelessWidget {
  final String settingName;
  final bool isOn;
  final ValueChanged<bool> onChanged;
   const SettingSwitch({super.key,required this.settingName,required this.isOn,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(smallWidth),
      ),
      color: context.appColors.settingListColor,
      child: Row(
        children: [
          Width(normalWidth),
          settingName.text.size(bigFontSize).color(Colors.black).fontWeight(FontWeight.w300).make(),
          const Spacer(),
          CupertinoSwitch(value: isOn, onChanged: onChanged),
        ],).paddingAll(smallHeight),
    );
  }
}
