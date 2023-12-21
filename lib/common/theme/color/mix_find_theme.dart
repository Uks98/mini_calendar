

import 'package:flutter/cupertino.dart';
import 'package:today_my_calendar/common/common.dart';

import '../custom_theme.dart';

mixin class ThemeDarkFind{
  bool isLightMode = false;
  void findDarkMode(BuildContext context){
    final theme = context.themeType;
    switch(theme){
      case CustomTheme.dark:
        isLightMode = true;
      case CustomTheme.light:
        isLightMode = false;
    }
    // if (theme == CustomTheme.dark) {
    //   print(theme);
    //   isDarkMode = true;
    // } else {
    //   print(theme);
    //   isDarkMode = false;
    // }
  }
}