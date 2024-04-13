import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:today_my_calendar/controller/month_data_controller.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import '../common/data/preference/prefs.dart';

class DayEvent with MonthControllerMix {
  String serviceKey =
      "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";

  void getEventList(String? year) async {
    var url =
        "https://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getAnniversaryInfo?serviceKey=$serviceKey&pageNo=1&numOfRows=80&solYear=$year&_type=json";
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String, dynamic>;
      if (res["response"] != null) {
        if (Prefs.isEventDay.get() == true) {
          for (final _res in res["response"]["body"]["items"]["item"]) {
            final m = Schedule.fromJson(_res as Map<String, dynamic>);
            monthControl.monthDataList.add(Schedule(
                title: m.title,
                from: m.from,
                to: m.from,
                colorIndex: 5,
                isAllDay: true,
                myPlace: "",
                id: 0,
                memo: m.title,
                isShowMap: false,
                holiday: m.holiday,
            ),);
          }
        }
        // Meeting 객체 처리
      }
    }
  }
///한국 공휴일 데이터
  void getHoliday(String? year) async {
    var url =
        "https://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?serviceKey=$serviceKey&solYear=2024&_type=json";
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String, dynamic>;
      if (res["response"] != null) {
        for (final _res in res["response"]["body"]["items"]["item"]) {
          final m = Schedule.fromHoliday(_res as Map<String, dynamic>);
          monthControl.monthDataList.add(Schedule(
              title: m.title,
              from: m.from,
              to: m.from,
              colorIndex: 7,
              isAllDay: true,
              id: 0,
              isShowMap: false,
              myPlace: "",
              memo: m.title,
              holiday: m.holiday
          ),);
        }

        // Meeting 객체 처리
      }
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
