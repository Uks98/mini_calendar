import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/common/dart/extension/context_extension.dart';
import 'package:today_my_calendar/common/widget/w_tap.dart';

import '../../common/widget/scaffold/center_dialog_scaffold.dart';
import '../../common/widget/w_line.dart';
import '../../controller/month_data_controller.dart';
import '../../data/simple_result.dart';


class MessageDialog extends DialogWidget<SimpleResult> {
  final String? message;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final bool cancelable;
  final TextAlign textAlign;
  final double fontSize;
  final CalendarLongPressDetails? calendarLongPressDetails;

  MessageDialog(
      this.message, {
        this.positiveButtonText,
        this.negativeButtonText,
        this.fontSize = 14,
        this.cancelable = true,
        this.textAlign = TextAlign.start,
        this.calendarLongPressDetails
      });

  @override
  State<StatefulWidget> createState() {
    return _MessageDialogState();
  }
}

class _MessageDialogState extends DialogState<MessageDialog> with MonthControllerMix {
  @override
  Widget build(BuildContext context) {
    return CenterDialogScaffold(
        body: Container(
            constraints: BoxConstraints(maxHeight: context.deviceHeight),
            decoration: BoxDecoration(
                color: context.appColors.drawerBg, borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          widget.message!,
                          style: TextStyle(
                              fontSize: widget.fontSize,
                              height: 1.8,
                              color: context.appColors.text),
                          textAlign: widget.textAlign,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    )
                  ],
                ),
                Line(color: context.appColors.divider),
                Row(
                  children: [
                    Expanded(
                      child: Tap(
                        onTap: () {
                          widget.hide(SimpleResult.success());
                          monthControl.calendarLongTapped(context, widget.calendarLongPressDetails!);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child:

                          Text(
                            widget.positiveButtonText ?? '예',
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Tap(
                        onTap: () {
                          widget.hide(SimpleResult.success());
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            widget.negativeButtonText ?? '아니오',
                            style: TextStyle(
                              color: context.appColors.text,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
