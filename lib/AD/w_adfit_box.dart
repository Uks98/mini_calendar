
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adfit/flutter_adfit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Adfit{
static Widget adfitAdvertise(AdFitBannerSize adFitBannerSize){
  //배너 DAN-wrTDMH78uLsidGtJ
  //배너 x DAN-avcrzMXm5vhW61BM
  return  Container(
    //width: 300.w,
    height: 50.h,
    color: Colors.white,
    child: AdFitBanner(
      adId:  "DAN-wrTDMH78uLsidGtJ",
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
  );
}
}