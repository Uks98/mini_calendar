

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

import '../../controller/month_data_controller.dart';
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
  ExpandableFab buildExpandableFab(BuildContext context) {
    return ExpandableFab(
      overlayStyle: ExpandableFabOverlayStyle(blur:  10.0),
      openButtonBuilder: buildRotateFloatingActionButtonBuilder(context, const Icon(Icons.add)),
      closeButtonBuilder: buildRotateFloatingActionButtonBuilder(context, const Icon(Icons.close)),
      type: ExpandableFabType.up,
      distance: distance,
      key: _floatingKey,
      children: [
        FloatingActionButton.small(
          heroTag: "b",
          backgroundColor: changeSmallFloatingColor,
          child: Icon(
            Icons.edit,
            color: changeSmallFloatingIconColor,
          ),
          onPressed: goToAddPage,
        ),
        FloatingActionButton.small(
          heroTag: "c",
          backgroundColor: changeSmallFloatingColor,
          child: Icon(
            Icons.settings,
            color: changeSmallFloatingIconColor,
          ),
          onPressed: goToSetPage,
        ),
      ],
    );
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