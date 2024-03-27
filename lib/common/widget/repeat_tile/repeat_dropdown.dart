import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:today_my_calendar/common/common.dart';
import 'dart:developer';

import '../../../controller/repeat_controller.dart';
import '../../constant/constant_widget.dart';

const List<String> _list = [
  "없음",
  "매일",
  "매주",
  "매월"
];

class SimpleDropdown extends StatefulWidget {
  const SimpleDropdown({Key? key}) : super(key: key);

  @override
  State<SimpleDropdown> createState() => _SimpleDropdownState();
}

class _SimpleDropdownState extends State<SimpleDropdown> with RepeatControllerMixin{
  final RepeatController repeatController1 = RepeatController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: CustomDropdown<String>(
        items: _list,
        initialItem: _list[0],
        onChanged: (value) {
          int selectedIndex = _list.indexOf(value);
          repeatController.repeatText.value = value;
          repeatController.repeatIndex.value = selectedIndex;
          print("스타트${repeatController.repeatIndex.value}");
        },
      ).pOnly(right: normalWidth),
    );
  }
}