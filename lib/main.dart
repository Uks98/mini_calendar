import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'app.dart';
import 'common/data/preference/app_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await NaverMapSdk.instance.initialize(clientId: "9sm04db48b");
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();
  _initNotiSetting();
  runApp(const App());
}
final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void _initNotiSetting() async {
  const initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Seoul")); //아시아 서울 시간대로

  // const initializationSettingsIOS = IOSInitializationSettings(
  //   requestAlertPermission: false,
  //   requestBadgePermission: false,
  //   requestSoundPermission: false,
  // );

  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}