

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

import '../../controller/month_data_controller.dart';
import '../../tab/s_calendar_search_page.dart';
import '../theme/color/mix_find_theme.dart';

class UtilFloating with ThemeDarkFind,MonthControllerMix{
  BuildContext buildContext;
  double distance;
  VoidCallback goToAddPage;
  VoidCallback goToSetPage;
  UtilFloating({
    required this.buildContext,
    required this.distance,
    required this.goToAddPage,
    required this.goToSetPage
  });

  Color get changeSmallFloatingColor => !isLightMode
      ? buildContext.appColors.calendarMainColor
      : buildContext.appColors.floatingIconColor;

  Color get changeSmallFloatingIconColor => isLightMode
      ? buildContext.appColors.calendarMainColor
      : buildContext.appColors.floatingIconColor;
  String month = "";

  final _floatingKey =
  GlobalKey<ExpandableFabState>();
  Padding buildExpandableFab(BuildContext context) {
    return ExpandableFab(
      //overlayStyle: ExpandableFabOverlayStyle(blur:  10.0),
      openButtonBuilder: buildRotateFloatingActionButtonBuilder(context, const Icon(Icons.add)),
      closeButtonBuilder: buildRotateFloatingActionButtonBuilder(context, const Icon(Icons.close)),
      type: ExpandableFabType.up,
      distance: distance,
      key: _floatingKey,
      children: [
        FloatingActionButton.small(
          heroTag: "b",
          backgroundColor: changeSmallFloatingColor,
          onPressed: goToAddPage,
          child: Icon(
            Icons.edit,
            color: changeSmallFloatingIconColor,
          ),
        ),
        FloatingActionButton.small(
          heroTag: "cs",
          backgroundColor: changeSmallFloatingColor,
          onPressed: goToSetPage,
          child: Icon(
            Icons.settings,
            color: changeSmallFloatingIconColor,
          ),
        ),
        FloatingActionButton.small(
          heroTag: "ts",
          backgroundColor: changeSmallFloatingColor,
          child: Icon(
            Icons.search_outlined,
            color: changeSmallFloatingIconColor,
          ),
          onPressed: () => Get.to(const CalendarSearchPage()),
        ),
      ],
    ).pOnly(bottom: 20.h);
  }
  RotateFloatingActionButtonBuilder buildRotateFloatingActionButtonBuilder(
      BuildContext context, Icon icon) {
    return RotateFloatingActionButtonBuilder(
      //heroTag: "f",
      child: icon,
      fabSize: ExpandableFabSize.regular,
      foregroundColor: context.appColors.floatingIconColor,
      backgroundColor: context.appColors.calendarMainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(normalHeight),
      ),
    );
  }
}