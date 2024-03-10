
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../data/location_data.dart';
import '../service/convert_locatoon_json_datal_ist.dart';

class MapDataController extends GetxController{
  RxList<LocationData> mapList = <LocationData>[].obs;
  //set 변경
  RxSet<LocationData> autoCompleteList = <LocationData>{}.obs;

  RxDouble gpsX = 0.0.obs;
  RxDouble gpsY = 0.0.obs;
  RxString myPlace = "".obs;
  RxBool isShowMap = false.obs;
  RxBool isMapLoading = true.obs;
  MapApi mapApi = MapApi();

  void searchLocation({required String keyword,required BuildContext context}){
    if(keyword.isEmpty){
      autoCompleteList.clear();
      return;
    }
    autoCompleteList.value = mapList.where((element) => element.placeName.contains(keyword)).toSet();
    getMapData(context, keyword);

  }

  void getMapData(BuildContext context,String search) async {
      mapList.value = (await mapApi.getMapList(context: context,search:search))!;
  }


  ///맵 로딩 처리 함수
  void startLoading() {
    isMapLoading.value = true;
  }

  void stopLoading() {
    isMapLoading.value = false;
  }

}