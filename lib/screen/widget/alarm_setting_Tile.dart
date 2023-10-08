import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

class AlarmSettingTile extends StatelessWidget {
  const AlarmSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          "알림".text.size(bigFontSize).make(),
      ContextMenuArea(
        child: "age".text.make(),
        width: 200.w,
        builder: (context) => [
          ListTile(title: "a".text.make(),)
        ],
      )
        ],
      ),
    );
  }
}
