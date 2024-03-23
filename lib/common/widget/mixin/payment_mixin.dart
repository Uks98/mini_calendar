

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';



import '../../../service/purechase_logic.dart';
import '../../constant/constant_widget.dart';

mixin class PaymentShowSheet{
  final InAppPurchaseService pureController = Get.put(InAppPurchaseService());
  void showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeightBox(normalHeight),
              Center(
                  child: Image.asset("assets/moco_icon.jpg",
                      fit: BoxFit.cover, width: 50.w, height: 50.h)),
              HeightBox(smallHeight),
              Center(
                child: Text('모코 캘린더'),
              ),
              HeightBox(normalHeight),
              "광고 제거".text.fontWeight(FontWeight.w500).size(bigFontSize).make(),
              HeightBox(normalHeight),
              "🌟 이 앱의 모든 광고가 숨겨집니다"
                  .text
                  .fontWeight(FontWeight.w300)
                  .size(bigFontSize)
                  .make(),
              HeightBox(normalHeight),
              "모든 기능 잠금 해제"
                  .text
                  .fontWeight(FontWeight.w500)
                  .size(bigFontSize)
                  .make(),
              HeightBox(normalHeight),
              "🌟 주 번호"
                  .text
                  .size(bigFontSize)
                  .fontWeight(FontWeight.w300)
                  .make(),
              HeightBox(normalHeight),
              "🌟 모든 색상 테마"
                  .text
                  .size(bigFontSize)
                  .fontWeight(FontWeight.w300)
                  .make(),
              HeightBox(normalHeight),
              Center(
                  child: "월액 과금 없음, 한번만 구입하여 평생 사용"
                      .text
                      .color(Colors.grey[500])
                      .size(smallFontSize)
                      .make()),
              HeightBox(smallHeight),
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          pureController.purchaseProduct(
                              InAppPurchaseService.to.products[0]
                          );
                        },
                        child: "업그레이드 2500원".text.make(),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(5), // 모서리 둥근 정도를 5로 설정
                          ),
                        ),
                      ),
                    ),
                  ],
                ).pOnly(right: bigWidth),
              ),
            ],
          ).pOnly(left: bigWidth),
        );
      },
    );
  }
}
