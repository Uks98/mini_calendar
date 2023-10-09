

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
  RxString alarmTime = "지정 시간".obs;

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
      case "없음": null;
      break;
      case "지정 시간": await zonedSchedule(notification, time, notiDay, detail,0);
      break;
      case "1분 전": await zonedSchedule(notification, time, notiDay, detail,1);
      break;
      case "5분 전": await zonedSchedule(notification, time, notiDay, detail,5);
      break;
      case "30분 전": await zonedSchedule(notification, time, notiDay, detail,30);
      break;
      case "1시간 전": await zonedSchedule(notification, time, notiDay, detail,60);
      break;
    }
    }

  Future<void> zonedSchedule(FlutterLocalNotificationsPlugin notification, DateTime time, int notiDay, NotificationDetails detail,int delTime) {
    return notification.zonedSchedule(
      2,
      "alarmTitle",
      "alarmDescription",
      tz.TZDateTime(tz.local, time.year, time.month, notiDay,
          time.hour, time.minute - delTime),
      detail,
      androidAllowWhileIdle: false,//주기적으로 표시
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      // payload: DateFormat('HH:mm').format(alarmTime),
    );
  }
  }