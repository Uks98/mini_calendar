import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:today_my_calendar/controller/month_data_controller.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import '../common/data/preference/prefs.dart';

class DayEvent with MonthControllerMix{
  void getEventList(String? year) async {
   // const String serviceKey = "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";
    var url = "api.openweathermap.org/data/2.5/forecast?lat=35.3112800&lon=128.9883630&appid=b0693b032a0f9043662de8e6fc9de5e8&units=metric";
    var response = await http.get(Uri.parse(url),);
    if (response.statusCode == 200) {
      List<Schedule?> eventList = [];
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String, dynamic>;
      if(res["list"]!=null){
        if(Prefs.isEventDay.get() == true){
          for (final _res in res["list"]["body"]["items"]["item"]) {
            final m = Schedule.fromJson(_res as Map<String, dynamic>);
            monthControl.monthDataList.add(Schedule(title: m.title, from: m.from, to: m.from, colorIndex: 5, isAllDay: true, id: 0,isShowMap: false,holiday: m.holiday));
          }
        }
        // Meeting 객체 처리
      }
    }else{
      print("error");
    }
  }
  void showDia(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("🚨알림🚨"),
            content: Text("데이터를 불러오지 못했어요 😭"),
          );
        });
  }
}

class WeatherData{
  String? id;
  String? tempMax;
  String? tempMin;
  String? day;
  String? icon;
}

