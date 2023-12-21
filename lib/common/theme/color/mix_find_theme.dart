

import 'package:flutter/cupertino.dart';
import 'package:today_my_calendar/common/common.dart';

import '../custom_theme.dart';

mixin class ThemeDarkFind{
  bool isDarkMode = false;
  void findDarkMode(BuildContext context){
    final theme = context.themeType;
    switch(theme){
      case CustomTheme.dark:
        isDarkMode = true;
        print(isDarkMode);
      case CustomTheme.light:
        isDarkMode = false;
        print(isDarkMode);
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