import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/widget/repeat_tile/repeat_dropdown.dart';

import '../../constant/constant_widget.dart';

class RepeatTile extends StatefulWidget {
  const RepeatTile({super.key});

  @override
  State<RepeatTile> createState() => _RepeatTileState();
}

class _RepeatTileState extends State<RepeatTile> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        "반복"
            .text
            .size(normalFontSize)
            .fontWeight(
          FontWeight.w300,
        ).make().paddingOnly(left: 5.h),
        SizedBox(
          width: smallWidth,
        ),
        const SimpleDropdown()
      ],
    );
  }
}
