import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nav/nav.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/screen/widget/w_calendar_add_page.dart';
import 'package:today_my_calendar/tab/s_main_screen.dart';

import 'common/theme/custom_theme.dart';
import 'common/theme/custom_theme_app.dart';

class App extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  ///light, dark 테마가 준비되었고, 시스템 테마를 따라가게 하려면 해당 필드를 제거 하시면 됩니다.
  static const defaultTheme = CustomTheme.light;
  static bool isForeground = true;

  App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> with Nav, WidgetsBindingObserver {
  App app = App();
  @override
  GlobalKey<NavigatorState> get navigatorKey => app.navigatorKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomThemeApp(
      child: Builder(builder: (context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          ),
          navigatorKey: app.navigatorKey,
          title: 'TodayCalendar',
          theme: context.themeType.themeData,
          home: const MainScreen(),
        );
      }),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        App.isForeground = true;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        App.isForeground = false;
        break;
      case AppLifecycleState.detached:
        break;

      // case AppLifecycleState.hidden:
      //  // TODO: Handle this case.
      //  break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
