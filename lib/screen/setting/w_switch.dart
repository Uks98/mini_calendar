

import 'package:flutter/cupertino.dart';
import 'package:today_my_calendar/common/common.dart';

class SettingSwitch extends StatelessWidget {
  final String settingName;
  final bool isOn;
  final ValueChanged<bool> onChanged;
   const SettingSwitch({super.key,required this.settingName,required this.isOn,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        settingName.text.make(),
        CupertinoSwitch(value: isOn, onChanged: onChanged),
      ],
    );
  }
}
