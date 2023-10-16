import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:today_my_calendar/Color/widget_Color.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
import '../../common/constant/constant_widget.dart';
import '../../controller/date_picker_controller.dart';
import 'package:get/get.dart';

class ShowDateStartPicker extends StatelessWidget with ScreenInit {
  String startText;
  DateTime dateTime;

  ShowDateStartPicker({
    super.key,
    required this.startText,
    required this.datePickerStateController,
    required this.dateTime,
  });

  DateTime get _selectedDate =>
      datePickerStateController.startSelectedTime.value;
  final DatePickerStateController datePickerStateController;

  @override
  Widget build(BuildContext context) {
    screenInit(context);
    return Row(
      children: [
        Tap(
          onTap: () => datePickerStateController.showStartPicker(),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      "${startText}".text.size(bigFontSize).make(),
                      Obx(() =>
                          formatTime(_selectedDate)
                              .text
                              .size(normalFontSize)
                              .color(ColorBox.pickerText)
                              .make()).pOnly(left: timeTextRightPaddingSize.w)
                    ],
                  ),
                ).w(390),
                if (datePickerStateController.isShowStartDatePicker.value)
                  SizedBox(
                    child: Center(
                      child: CupertinoDatePicker(
                        dateOrder: DatePickerDateOrder.ymd,
                        minimumYear: 2010,
                        maximumYear: DateTime.now().year,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (date) =>
                            datePickerStateController.startTimeChanged(date),
                        mode: CupertinoDatePickerMode.dateAndTime,
                      ),
                    ),
                  ).w(350).h(100).pOnly(top: smallHeight),
              ],
            ),
          ),
        ),
      ],
    );
  }
  String formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMM dd일 HH시 mm분');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}

class ShowDateLastPicker extends StatelessWidget with ScreenInit {
  String startText;
  DateTime dateTime;

  ShowDateLastPicker({
    super.key,
    required this.startText,
    required this.datePickerStateController,
    required this.dateTime,
  });

  DateTime get _selectedDate =>
      datePickerStateController.lastSelectedTime.value;
  final DatePickerStateController datePickerStateController;

  @override
  Widget build(BuildContext context) {
    screenInit(context);
    return Row(
      children: [
        Tap(
          onTap: () => datePickerStateController.showLastPicker(),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      "${startText}".text.size(bigFontSize).make(),
                      Obx(() =>
                              formatTime(_selectedDate)
                              .text
                              .size(normalFontSize)
                              .color(ColorBox.pickerText)
                              .make()).pOnly(left: timeTextRightPaddingSize.w)
                    ],
                  ),
                ).w(390),
                if (datePickerStateController.isShowLastDatePicker.value)
                  SizedBox(
                      child: Center(
                    child: Obx(
                      () => CupertinoDatePicker(
                        use24hFormat: false,
                        dateOrder: DatePickerDateOrder.ymd,
                        minimumYear: 2010,
                        maximumYear: 2099,
                        initialDateTime: _selectedDate.add(Duration(
                            minutes: datePickerStateController.addTime.value)),
                        onDateTimeChanged: (date) {
                          datePickerStateController.lastTimeChanged(date);
                          },
                        mode: CupertinoDatePickerMode.dateAndTime,
                      ),
                    ),
                  ).w(390).h(100).pOnly(top: smallHeight)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMM dd일 HH시 mm분');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}
