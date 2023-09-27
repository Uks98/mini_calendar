import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:today_my_calendar/common/common.dart';
import '../../common/constant/constant_widget.dart';
import '../../controller/date_picker_controller.dart';

class ShowDatePicker extends StatelessWidget {
  String startText;
  DateTime dateTime;

  ShowDatePicker({
    super.key,
    required this.startText,
    required this.datePickerStateController,
    required this.dateTime,
  });
  DateTime get _selectedDate => datePickerStateController.startSelectedTime.value;
  final DatePickerStateController datePickerStateController;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tap(
          onTap: ()=> datePickerStateController.showStartPicker(),
          child:Obx(()=>Column(
            children: [
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${startText}".text.size(bigFontSize).make(),
                    Obx(()=>"${dateTime.month}월 ${dateTime.day}일  ${_selectedDate.hour} : ${_selectedDate.minute}"
                        .text
                        .size(bigFontSize)
                        .make())
                  ],
                ),
              ).w(380),
              if (datePickerStateController.isShowStartDatePicker.value)
                SizedBox(
                  width: 350,
                  height: 100,
                  child: Center(
                    child: CupertinoDatePicker(
                      dateOrder: DatePickerDateOrder.ymd,
                      minimumYear: 2010,
                      maximumYear: DateTime.now().year,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (date) =>datePickerStateController.startTimeChanged(date),
                      mode: CupertinoDatePickerMode.time,
                    ),
                  ),
                ).w(350).h(100),
            ],
          ),
          ),),
      ],
    );
  }
}