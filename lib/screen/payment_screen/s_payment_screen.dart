import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../service/purechase_logic.dart';

class PremiumView extends GetView<InAppPurchaseService> {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    final InAppPurchaseService pureController = Get.put(InAppPurchaseService());
    return Scaffold(
      body: SizedBox(
        width: 200,
        height: 100,
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 버튼 클릭 시 수행할 작업
                  pureController.purchaseProduct(
                      InAppPurchaseService.to.products[0]
                  );

                },
                child: const Text('프리미엄 회원으로 업그레이드하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}