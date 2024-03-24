import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/widget/mixin/payment_mixin.dart';
import 'package:today_my_calendar/screen/setting/w_setting_font_tile.dart';
import '../../common/data/preference/prefs.dart';

class FontChangeScreen extends StatefulWidget {
  const FontChangeScreen({super.key});

  @override
  State<FontChangeScreen> createState() => _FontChangeScreenState();
}

class _FontChangeScreenState extends State<FontChangeScreen> with PaymentShowSheet{
  bool isMatchFont(String match) {
    bool matchFont = Prefs.currentFont.get().toString() == match.toString();
    return matchFont;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "설정".text.size(normalFontSize).make(),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: bigHeight,
          ),
          "폰트는 앱을 재시작하면 적용됩니다.".text.size(normalFontSize).color(Colors.grey[300]).make(),
          SettingFontTile(
            title: '드림 폰트 입니다. 012345678 Hello',
            icon: EvaIcons.brushOutline,
            checkIcon: isMatchFont("dream")
                ? EvaIcons.checkmarkSquare
                : EvaIcons.square,
            fontFamily: 'dream',
            callBack: () {
              Prefs.currentFont.set("dream");
              isMatchFont("dream");
              setState(() {});
            },
          ),
          SettingFontTile(
            title: Prefs.isPurchaseApp.get() == true ? "북크크 폰트입니다. 012345678 Hello": '[북크크] 잠겨있는 폰트입니다. 012345678 Hello',
            icon: EvaIcons.brushOutline,
            checkIcon: Prefs.isPurchaseApp.get() == true && isMatchFont("bukk") == true
                ? EvaIcons.checkmarkSquare
                : EvaIcons.square,
            fontFamily: 'bukk',
            callBack: () {
              if(Prefs.isPurchaseApp.get() == false){
                showPaymentSheet(context);
              }
              Prefs.currentFont.set("bukk");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
