import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/location_data.dart';

//required String keyword, required int page,
class MapApi{
  List<LocationData> locationData = [];
  Future<List<LocationData>?> getMapList({required BuildContext context, required String search}) async {
    var url = "https://dapi.kakao.com/v2/local/search/keyword.json?query=$search";
    var response = await http.get(Uri.parse(url), headers: {"Authorization": "KakaoAK f3b7ba5c3471908bae3560e58f3a43ed"});
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String,dynamic>;

      if(res["documents"] == ""){
        showDia(context);
      }
      for(final _res in res["documents"]){
        final m = LocationData.fromJson(_res as Map<String,dynamic>);
        locationData.add(m);
      }
    }
    return locationData;
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
  void showDia(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            title: Text("🚨알림🚨"),
            content: Text("마지막 정보에요 😭"),
          );
        }
    );
  }
}

//
// class LocationClass{
//   static var longitude;
//   static var latitude;
//
//   void getLocation(BuildContext context) async {
//     LocationPermission per = await Geolocator.checkPermission();
//     if (per == LocationPermission.denied ||
//         per == LocationPermission.deniedForever) {
//       toastMessage(context,"위치를 허용해주세요");
//       LocationPermission per1 = await Geolocator.requestPermission();
//     } else {
//       Position currentLoc = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);
//       toastMessage(context, "정보를 불러왔습니다.",);
//       longitude = currentLoc.longitude;
//       latitude = currentLoc.latitude;
//       print(longitude);
//       print(latitude);
//     }
//   }
//   void toastMessage(BuildContext context,String text){
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text),backgroundColor: Colors.white,));
//   }
// }