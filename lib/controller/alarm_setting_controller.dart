

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:today_my_calendar/common/common.dart';
import 'dart:io';
import '../common/constant/constant_widget.dart';
import '../main.dart';

class AlarmSettingController extends GetxController{
  RxString alarmTime = "없음".obs;

  int get newId => DateTime.now().microsecond;

    static final notification = flutterLocalNotificationsPlugin;

    final alarmList = [];

  void getAlarmTime({required String id,required DateTime time, required String setTextTime,required BuildContext context,required String title,required String memo})async{
    final now = tz.TZDateTime.now(tz.local);
    final dateNow = DateTime.parse(now.toString());
    var notiDay = dateNow.day;
     final android = AndroidNotificationDetails(
       id,
      "알림",
      channelDescription: "알림이",
      importance: Importance.max,
      priority: Priority.max,
     // icon: "assets/moco.png"
    );
     final detail = NotificationDetails(
      android: android,
    );
    final permission = Platform.isAndroid;
    if (!permission) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "알람권한을 설정해주세요".text.size(bigFontSize).make()));
      return;
    }


    // await flutterLocalNotificationsPlugin.show(1, "title", "body", detail);
    // 예외처리
   // if (time.hour > dateNow.hour || time.hour == dateNow.hour && now.minute >= dateNow.minute) {
   //   notiDay = notiDay + 1;
   // }
    switch(setTextTime){
      case "없음": null;
      break;
      case "지정 시간": await zonedSchedule(newId,notification,time, notiDay, detail,0,title,memo);
      break;
      case "5분 전": await zonedSchedule(newId,notification, time, notiDay, detail,5,title,memo);
      break;
      case "30분 전": await zonedSchedule(newId,notification, time, notiDay, detail,30,title,memo);
      break;
      case "1시간 전": await zonedSchedule(newId,notification, time, notiDay, detail,60,title,memo);
      break;
    }
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannelGroup(id);
    //await cancelAlarm(int.parse(id)); //캔슬 알람 테스트 . . .
    }

  Future<void> zonedSchedule(int id,FlutterLocalNotificationsPlugin notification, DateTime time, int notiDay, NotificationDetails detail,int delTime,String title, String content) {
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

    final selfTime = tz.TZDateTime(tz.local, time.year, time.month, time.day,
        time.hour, time.minute - delTime);

    print("내가 지정한 시간$selfTime");
    return notification.zonedSchedule(
      id, //알람 아이디 값 유니크하게 변경(유니크 해야 알람이 각각 지정)
      title,
      content,
      selfTime,
      detail,
      androidAllowWhileIdle: true,//주기적으로 표시
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
      payload: DateFormat('MM월:dd일 HH시 mm분').format(selfTime),
    );
  }
  Future<void> cancelAlarm(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
