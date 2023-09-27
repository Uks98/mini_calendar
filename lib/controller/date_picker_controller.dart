
import 'package:get/get.dart';

class DatePickerStateController extends GetxController{
  RxBool isShowStartDatePicker = false.obs;
  RxBool isShowLastDatePicker = false.obs;
  var startSelectedTime = DateTime.now().obs;
  var lastSelectedTime = DateTime.now().obs;
  void showStartPicker(){
    isShowStartDatePicker.value = !isShowStartDatePicker.value;
  }
  ///데이트 픽커 변경 시 텍스트가 변경되는 함수
  void startTimeChanged(DateTime date){
    startSelectedTime.value = date;
  }
  ///데이트 픽커 변경 시 텍스트가 변경되는 함수 마지막시간
  void lastTimeChanged(DateTime date){
    lastSelectedTime.value = date;
  }
}