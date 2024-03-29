import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/data/preference/prefs.dart';
import 'package:today_my_calendar/controller/setting_calendardata_controller.dart';

import '../../../controller/repeat_controller.dart';
import '../../constant/constant_widget.dart';

const List<String> _list = [
  "일","월"
];

class SimpleDropdown extends StatefulWidget {
  const SimpleDropdown({Key? key}) : super(key: key);

  @override
  State<SimpleDropdown> createState() => _SimpleDropdownState();
}

class _SimpleDropdownState extends State<SimpleDropdown> with RepeatControllerMixin,SettingCalendarControllerMix{
  final RepeatController repeatController1 = RepeatController();
  bool get isLightModes =>  Prefs.isLightModes.get();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: CustomDropdown<String>(
        decoration: CustomDropdownDecoration(
            expandedFillColor: isLightModes ? Color(0xff282828):Color(0xffF5F7F8) ,
          closedFillColor: isLightModes ? Color(0xff282828):Color(0xffF5F7F8) ,
          listItemStyle: TextStyle(color: !isLightModes ? Colors.black : Colors.white),
          headerStyle: TextStyle(color: !isLightModes ? Colors.black : Colors.white),
        ),
        items: _list,
        initialItem: Prefs.startDay.get() == "월" ? "월" : "일", //사용자가 선택한 시작요일에 따름
        onChanged: (value) {
          settingCalendarController.startDay.value = value;
          Prefs.startDay.set(settingCalendarController.startDay.value);
        },
      ).p(4.w),
    );
  }
}