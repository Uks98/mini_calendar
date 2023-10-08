

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:today_my_calendar/common/common.dart';
import 'dart:io';
import '../common/constant/constant_widget.dart';
import '../main.dart';

class AlarmSettingController extends GetxController{
  void getAlarmTime({required DateTime time, required String setTextTime,required BuildContext context,})async{
    final now = tz.TZDateTime.now(tz.local);
    final dateNow = DateTime.parse(now.toString());
    var notiDay = dateNow.day;
    final notification = flutterLocalNotificationsPlugin;
    const android = AndroidNotificationDetails(
      '0',
      "알림테스트",
      channelDescription: "toText",
      importance: Importance.max,
      priority: Priority.max,
    );
    const detail = NotificationDetails(
      android: android,
    );
    final permission = Platform.isAndroid;
    if (!permission) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "알람권한을 설정해주세요".text.size(bigFontSize).make()));
      return;
    }
    // await flutterLocalNotificationsPlugin.show(1, "title", "body", detail);
    // 예외처리
    if (time.hour > dateNow.hour || time.hour == dateNow.hour && now.minute >= dateNow.minute) {
      notiDay = notiDay + 1;
    }
    switch(setTextTime){
      case "지정 시간": await notification.zonedSchedule(
        1,
        "alarmTitle",
        "alarmDescription",
        tz.TZDateTime(tz.local, time.year, time.month, notiDay,
            time.hour, time.minute),
        detail,
        androidAllowWhileIdle: false,//주기적으로 표시
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        // payload: DateFormat('HH:mm').format(alarmTime),
      );
      break;
      case "1분" : await notification.zonedSchedule(
        2,
        "alarmTitle",
        "alarmDescription",
        tz.TZDateTime(tz.local, time.year, time.month, notiDay,
            time.hour, time.minute + 1),
        detail,
        androidAllowWhileIdle: false,//주기적으로 표시
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        // payload: DateFormat('HH:mm').format(alarmTime),
      );
      break;
    }
    }
  }