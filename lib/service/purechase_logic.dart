// ignore_for_file: unnecessary_cast

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../common/data/preference/prefs.dart';

/// 인앱 결제 서비스
class InAppPurchaseService extends GetxController {
  static InAppPurchaseService get to => Get.find();

  // Instance ▼ ============================================

  /// 구매를 위한 인스턴스를 가져옵니다.
  final Rx<InAppPurchase> iap = InAppPurchase.instance.obs;

  // 구매 세부 정보에 대한 업데이트 스트림을 수신하는 구독
  late Rx<StreamSubscription?> subscription = (null as StreamSubscription?).obs;

  // Data ▼ ================================================

  /// 구매를 위한 인스턴스를 가져옵니다.
  RxString productID = 'moco_test_100'.obs;
  // Playstore 또는 앱 스토어에서 쿼리한 제품 목록 유지
  RxList<ProductDetails> products = <ProductDetails>[].obs;
  // 과거 구매 사용자 목록
  RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;

  // Function ▼ ============================================

  /// 상품 목록 조회 방법
  ///
  /// Future<void>
  Future<void> fetchUserProducts() async {
    // 구매를 위한 인스턴스를 가져옵니다.
    ProductDetailsResponse response = await iap.value.queryProductDetails({
      productID.value,
    });

    // 제품 목록 데이터 추가
    products.assignAll(response.productDetails);
  }

  /// 과거 구매 사용자를 검색하는 방법
  ///
  /// @return Future<void>
  Future<void> fetchPastPurchases() async {
    /// 모든 이전 구매를 복원합니다.
    /// `applicationUserName`은 초기 `PurchaseParam`에서 전송된 내용과 일치해야 합니다.
    /// 초기 `PurchaseParam`에 `applicationUserName`이 지정되지 않은 경우 null을 사용합니다.
    /// 복원된 구매는 [PurchaseStatus.restored] 상태로 [purchaseStream]을 통해 전달됩니다.
    /// 이러한 구매를 수신하고, 영수증을 확인하고, 콘텐츠를 전달하고, 각 구매에 대해 [finishPurchase] 메서드를 호출하여 구매 완료를 표시해야 합니다.
    /// 이것은 소비된 제품을 반환하지 않습니다.
    /// `사용하지 않는 소모품을 복원하려면 자체 서버에서 사용자에 대한 소모품 정보를 유지해야 합니다.`
    // await iap.value.restorePurchases();
  }

  /// 상품을 이미 구매했는지 여부를 확인하는 방법입니다.
  ///
  /// @return void
  void verifyPurchases() {
    try {
      PurchaseDetails purchase = purchases.firstWhere(
            (purchase) => purchase.productID == productID.value,
      );
      if (purchase.status == PurchaseStatus.purchased) {
        // 구매 완료
      }
    } catch (e) {
      // 구매 미완료
    }
  }

  /// 제품 구매 방법
  ///
  /// [prod] 구매할 제품
  ///
  /// @return 구매 성공 여부
  @required
  void purchaseProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    iap.value.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
    Prefs.isPurchaseApp.set(true); /// 입앱 구매했는지
    Prefs.isWeekNum.set(true); /// 주번호
  }

  /// 구매 세부 정보에 대한 업데이트 스트림을 수신하는 구독
  ///
  /// @return Future<void>
  Future<void> initialize() async {
    // 인앱 구매가 가능한지 체크
    if (await iap.value.isAvailable()) {
      // 구매 가능한 상품 목록 조회
      await fetchUserProducts();
      // 과거 구매 사용자 목록 조회
      // await fetchPastPurchases();
      // 상품을 이미 구매했는지 체크
      verifyPurchases();

      // 구매 세부 정보에 대한 업데이트 스트림을 수신하는 구독
      subscription.value = iap.value.purchaseStream.listen((data) {
        // 구매 세부 정보를 업데이트
        purchases.addAll(data);
        // 상품을 이미 구매했는지 체크
        verifyPurchases();
      });
    }
  }

  @override
  Future<void> onInit() async {
    await initialize();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // 구독 해제
    subscription.value?.cancel();

    super.onClose();
  }
}