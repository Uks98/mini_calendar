

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';



import '../../../service/purechase_logic.dart';
import '../../constant/app_colors.dart';
import '../../constant/constant_widget.dart';

mixin class PaymentShowSheet{
  final InAppPurchaseService pureController = Get.put(InAppPurchaseService());
  void showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeightBox(bigHeight),
             "프리미엄".text.fontWeight(FontWeight.w700).size(bigFontSize + 5).make(),
              HeightBox(smallHeight),
              " 프리미엄으로 업그레이드하여 모든 기능을 제한 없이\n 사용하세요. 한번만 결제하시면 평생 사용하실 수\n 있습니다."
                  .text
                  .color(Colors.grey[600])
                  .size(smallFontSize)
                  .make(),
              HeightBox(normalHeight),
              "⦁ 모든 광고 제거".text.size(bigFontSize).fontWeight(FontWeight.w300).make(),
              HeightBox(normalHeight),
              "⦁ 주 번호"
                  .text
                  .size(bigFontSize)
                  .fontWeight(FontWeight.w300)
                  .make(),
              HeightBox(normalHeight),
              "⦁ 모든 색상 테마"
                  .text
                  .size(bigFontSize)
                  .fontWeight(FontWeight.w300)
                  .make(),
              HeightBox(normalHeight),
              "⦁ 맞춤형 폰트"
                  .text
                  .size(bigFontSize)
                  .fontWeight(FontWeight.w300)
                  .make(),
              HeightBox(normalHeight),
              "⦁ AI 텍스트 인식"
                  .text
                  .size(bigFontSize)
                  .fontWeight(FontWeight.w300)
                  .make(),
              HeightBox(normalHeight),

              HeightBox(normalHeight),
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 400.w,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () {
                            pureController.purchaseProduct(
                                InAppPurchaseService.to.products[0]
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5), // 모서리 둥근 정도를 5로 설정
                            ),
                          ),
                          child: "평생 업그레이드 2500원".text.color(Colors.white).size(bigFontSize).fontWeight(FontWeight.w700).make(),
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
