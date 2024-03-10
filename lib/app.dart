import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/tab/s_main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []); //상태창 없애기 메서드
    return CustomThemeApp(
      child: Builder(builder: (context) {
        return GetMaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // 영어
            Locale('ko'), // 한국어
          ],
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
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
    super.didChangeAppLifecycleState(state);
  }
}
