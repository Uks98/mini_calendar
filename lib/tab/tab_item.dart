import 'package:flutter/material.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/tab/s_calendar_day_page.dart';
import 'package:today_my_calendar/tab/s_calendar_month_page.dart';
import 'package:today_my_calendar/tab/s_setting_page.dart';



enum TabItem {
  calendarMonth(Icons.home, '내 주변', CalendarMonthPage()),
  calendarDay(Icons.view_day, '유가 동향',CalendarDayPage()),
  settingPage(Icons.star, '설정', SettingPage()
  );

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage, {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toNavigationBarItem(BuildContext context, {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color:
              isActivated ? context.appColors.iconButton : context.appColors.iconButtonInactivate,
        ),
        label: tabName);
  }
}
