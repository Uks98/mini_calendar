import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:today_my_calendar/common/widget/mixin/init_screen_size_utill.dart';
import 'package:today_my_calendar/screen/widget/w_menu_drawer.dart';

import '../../common/common.dart';
import '../common/theme/color/mix_find_theme.dart';
import '../controller/month_data_controller.dart';
import 'tab_item.dart';
import 'tab_navigator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin,ThemeDarkFind,MonthControllerMix,ScreenInit {
  TabItem _currentTab = TabItem.calendarMonth;
  //바텀 네이베이션 탭
  final tabs = [TabItem.calendarMonth,TabItem.calendarDay];
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  int get _currentIndex => tabs.indexOf(_currentTab);

  GlobalKey<NavigatorState> get _currentTabNavigationKey => navigatorKeys[_currentIndex];

  bool get extendBody => true;

  static double get bottomNavigationBarBorderRadius => 15.0;

  final _floatingKey =
  GlobalKey<ExpandableFabState>(); // floating action button global key

  Color get changeSmallFloatingColor => !isLightMode
      ? context.appColors.calendarMainColor
      : context.appColors.floatingIconColor;

  Color get changeSmallFloatingIconColor => isLightMode
      ? context.appColors.calendarMainColor
      : context.appColors.floatingIconColor;
  String month = "";
  @override
  void initState() {
    super.initState();
    initNavigatorKeys();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackPressed,
      child: Scaffold(
        key: Key("abxsw"),
        extendBody: extendBody, //bottomNavigationBar 아래 영역 까지 그림
        body: Container(
          color: context.appColors.seedColor.getMaterialColorValues[200],
          padding: EdgeInsets.only(bottom: extendBody ? 60 - bottomNavigationBarBorderRadius : 0),
          child: SafeArea(
            bottom: !extendBody,
            child: pages,
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  IndexedStack get pages => IndexedStack(
      index: _currentIndex,
      children: tabs
          .mapIndexed((tab, index) => Offstage(
        offstage: _currentTab != tab,
        child: TabNavigator(
          navigatorKey: navigatorKeys[index],
          tabItem: tab,
        ),
      ))
          .toList());

  Future<bool> _handleBackPressed() async {
    final isFirstRouteInCurrentTab =
    (await _currentTabNavigationKey.currentState?.maybePop() == false);
    if (isFirstRouteInCurrentTab) {
      if (_currentTab != TabItem.calendarMonth) {
        _changeTab(tabs.indexOf(TabItem.calendarMonth));
        return false;
      }
    }
    // maybePop 가능하면 나가지 않는다.
    return isFirstRouteInCurrentTab;
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(bottomNavigationBarBorderRadius),
          topRight: Radius.circular(bottomNavigationBarBorderRadius),
        ),
          child: BottomNavigationBar(
            items: navigationBarItems(context),
            currentIndex: _currentIndex,
            selectedItemColor: context.appColors.text,
            unselectedItemColor: context.appColors.iconButtonInactivate,
            onTap: _handleOnTapNavigationBarItem,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),

      ),
    );
  }

  List<BottomNavigationBarItem> navigationBarItems(BuildContext context) {
    return tabs
        .mapIndexed(
          (tab, index) => tab.toNavigationBarItem(
        context,
        isActivated: _currentIndex == index,
      ),
    ).toList();
  }

  void _changeTab(int index) {
    setState(() {
      _currentTab = tabs[index];
    });
  }

  BottomNavigationBarItem bottomItem(
      bool activate, IconData iconData, IconData inActivateIconData, String label) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(label),
          activate ? iconData : inActivateIconData,
          color: activate ? context.appColors.iconButton : context.appColors.iconButtonInactivate,
        ),
        label: label);
  }

  void _handleOnTapNavigationBarItem(int index) {
    final oldTab = _currentTab;
    final targetTab = tabs[index];
    if (oldTab == targetTab) {
      final navigationKey = _currentTabNavigationKey;
      popAllHistory(navigationKey);
    }
    _changeTab(index);
  }

  void popAllHistory(GlobalKey<NavigatorState> navigationKey) {
    final bool canPop = navigationKey.currentState?.canPop() == true;
    if (canPop) {
      while (navigationKey.currentState?.canPop() == true) {
        navigationKey.currentState!.pop();
      }
    }
  }

  void initNavigatorKeys() {
    for (final _ in tabs) {
      navigatorKeys.add(GlobalKey<NavigatorState>());
    }
  }

}
