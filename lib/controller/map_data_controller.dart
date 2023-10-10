
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../data/location_data.dart';
import '../service/convert_locatoon_json_datal_ist.dart';

class MapDataController extends GetxController{
  RxList<LocationData> mapList = <LocationData>[].obs;
  RxList<LocationData> autoCompleteList = <LocationData>[].obs;
  RxString myPlace = "".obs;
  MapApi mapApi = MapApi();
  void searchLocation({String keyword = "무실동"}){
    if(keyword.isEmpty){
      autoCompleteList.clear();
      return;
    }
    autoCompleteList.value = mapList.where((element) => element.placeName.contains(keyword)).toList();
    print(autoCompleteList.toString());
  }


  void getMapData(BuildContext context,String search) async {
      mapList.value = (await mapApi.getMapList(context: context,search:"무실동"))!;
  }
}