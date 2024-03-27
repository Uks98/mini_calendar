
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adfit/flutter_adfit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

import '../common/data/preference/prefs.dart';

class AdfitBox{
static Widget adfitAdvertise(AdFitBannerSize adFitBannerSize,VoidCallback callBack){
  //배너 DAN-wrTDMH78uLsidGtJ
  //배너 x DAN-avcrzMXm5vhW61BM
  return  Prefs.isPurchaseApp.get() == false ? Column(
    children: [
      AdFitBanner(
        adId:  "",
        adSize: adFitBannerSize,
        listener: (AdFitEvent event, AdFitEventData data) {
          switch (event) {
            case AdFitEvent.AdReceived:
              break;
            case AdFitEvent.AdClicked:
              break;
            case AdFitEvent.AdReceiveFailed:
              break;
            case AdFitEvent.OnError:
              break;
          }
        },
      ),
      HeightBox(smallHeight),
      GestureDetector(
          onTap: callBack,
          child: "광고 제거".text.size(smallFontSize).fontWeight(FontWeight.w500).make()),
    ],
  ).pOnly(top: smallHeight) : const SizedBox();
}
}