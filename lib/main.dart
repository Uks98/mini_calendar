import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'app.dart';
import 'common/data/preference/app_preferences.dart';
import 'data/local/local_db.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: "o8936mrkdm");
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();
  await LocalDB.init();
  _initNotiSetting();

  runApp(App());
}
final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void _initNotiSetting() async {
  const initializationSettingsAndroid =
  AndroidInitializationSettings('moco');
  tz.initializeTimeZones();


  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}