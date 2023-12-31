import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';
import 'mix_find_theme.dart';


typedef ColorProvider = Color Function();

abstract class AbstractThemeColors{
  const AbstractThemeColors();

  Color get seedColor => const Color(0xfff6f6f6);

  Color get veryBrightGrey => AppColors.brightGrey;

  Color get drawerBg => const Color.fromARGB(255, 255, 255, 255);

  Color get scrollableItem => const Color.fromARGB(255, 57, 57, 57);

  Color get iconButton => const Color.fromARGB(255, 0, 0, 0);

  Color get iconButtonInactivate => const Color.fromARGB(255, 162, 162, 162);

  Color get inActivate => const Color.fromARGB(255, 200, 207, 220);

  Color get activate => const Color.fromARGB(255, 63, 72, 95);

  Color get badgeBg => AppColors.blueGreen;

  Color get textBadgeText => Colors.white;

  Color get badgeBorder => Colors.transparent;

  Color get divider => const Color.fromARGB(255, 228, 228, 228);

  Color get text => AppColors.darkGrey;

  Color get dtext => AppColors.darkGrey;

  Color get hintText => AppColors.middleGrey;

  Color get focusedBorder => AppColors.darkGrey;

  Color get confirmText => AppColors.blue;

  Color get drawerText => text;

  Color get snackbarBgColor => AppColors.mediumBlue;

  Color get blueButtonBackground => AppColors.darkBlue;

  Color get todayTileColor => const Color.fromARGB(255, 228, 228, 228);

  Color get floatingIconColor => const Color(0xffF3EEEA);

  Color get calendarMainColor => const Color(0xff0F0F0F);

  Color get todaySelectedColor => const Color(0xff4E4FEB);

  Color get settingListColor => const Color(0xffF2F1EB);





}
