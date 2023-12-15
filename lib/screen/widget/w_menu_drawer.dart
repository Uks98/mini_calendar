import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../common/common.dart';
import '../../common/theme/theme_util.dart';
import '../../common/widget/w_mode_switch.dart';
import 'd_message.dart';

class MenuDrawer extends StatefulWidget {
  static const minHeightForScrollView = 380;

  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Tap(
          onTap: () {
            closeDrawer(context);
          },
          child: Tap(
            onTap: () {},
            child: Container(
              width: 240,
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                  color: context.colors.background),
              child: isSmallScreen(context)
                  ? SingleChildScrollView(
                child: getMenus(context),
              )
                  : getMenus(context),
            ),
          ),
        ),
      ),
    );
  }

  bool isSmallScreen(BuildContext context) =>
      context.deviceHeight < MenuDrawer.minHeightForScrollView;

  Container getMenus(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: context.deviceHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(EvaIcons.close),
                  onPressed: () {
                    closeDrawer(context);
                  },
                  padding: const EdgeInsets.only(
                    top: 0,
                    right: 20,
                    left: 20,
                  ),
                ),
              )
            ],
          ),
          const Height(10),
          const Line(),
          // _MenuWidget(
          //   'opensource'.tr(),
          //   onTap: () async {
          //     Nav.push(const OpensourceScreen());
          //   },
          // ),
          const Line(),
          _MenuWidget(
            'clear_cache'.tr(),
            onTap: () async {
              final manager = DefaultCacheManager();
              await manager.emptyCache();
            },
          ),
          const Line(),
         // isSmallScreen(context) ? const Height(10) : const EmptyExpanded(),
          //다크모드 스위치
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ModeSwitch(
              value: context.isDarkMode,
              onChanged: (value) {
                ThemeUtil.toggleTheme(context);
              },
              height: 30,
              //activeThumbImage: Image.asset('$basePath/darkmode/moon.png'),
              //inactiveThumbImage: Image.asset('$basePath/darkmode/sun.png'),
              activeThumbColor: Colors.transparent,
              inactiveThumbColor: Colors.transparent,
            ).pOnly(left: 20),
          ),
          const Height(10),
          Row(
            children: [
              Expanded(
                child: Tap(
                  child: Container(
                      height: 30,
                      width: 100,
                      padding: const EdgeInsets.only(left: 15),
                      child: '© 2023. Bansook Nam. all rights reserved.'
                          .selectableText
                          .size(10)
                          .make()),
                  onTap: () async {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void toggleTheme() {
    ThemeUtil.toggleTheme(context);
  }

  void closeDrawer(BuildContext context) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }
  }


  Widget flag(String path) {
    return SimpleShadow(
      opacity: 0.5,
      // Default: 0.5
      color: Colors.grey,
      // Default: Black
      offset: const Offset(2, 2),
      // Default: Offset(2, 2)
      sigma: 2,
      // Default: 2
      child: Image.asset(
        path,
        width: 20,
      ),
    );
  }
}

class _MenuWidget extends StatelessWidget {
  final String text;
  final Function() onTap;

  const _MenuWidget(this.text, {Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Tap(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 20),
          child: Row(
            children: [
              Expanded(
                  child: text.text
                      .color(context.appColors.drawerText)
                      .size(15)
                      .make()),
            ],
          ),
        ),
      ),
    );
  }
}
