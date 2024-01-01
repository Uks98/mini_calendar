

import 'package:flutter/cupertino.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/data/preference/prefs.dart';

import '../custom_theme.dart';

mixin class ThemeDarkFind{
  bool isLightMode = false;
  void findDarkMode(BuildContext context){
    final theme = context.themeType;
    switch(theme){
      case CustomTheme.dark:
        isLightMode = true;
        Prefs.isLightModes(isLightMode);
        print(Prefs.isLightModes.get());
      case CustomTheme.light:
        isLightMode = false;
        Prefs.isLightModes(isLightMode);
        print(Prefs.isLightModes.get());
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