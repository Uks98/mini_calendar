
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../controller/month_data_controller.dart';
import '../common.dart';
import '../data/preference/prefs.dart';
import 'custom_theme.dart';

class ThemeUtil with MonthControllerMix{
  static Brightness get systemBrightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  static void changeTheme(BuildContext context, CustomTheme theme) {
    Prefs.appTheme.set(theme); // 또는 Prefs.appTheme(theme) 이렇게 저장도 가능
    context.changeTheme(theme);
  }

  //다크모드 토글
   void toggleTheme(BuildContext context) {
    final theme = context.themeType;
    switch (theme) {
      case CustomTheme.dark:
        changeTheme(context, CustomTheme.light);
        break;
      case CustomTheme.light:
        changeTheme(context, CustomTheme.dark);
        break;
    }
  }
}
