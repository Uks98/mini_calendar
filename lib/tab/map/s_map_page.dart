import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:today_my_calendar/common/common.dart';
import '../../controller/month_data_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with MonthControllerMix {
  @override
  Widget build(BuildContext context) {
    NCameraPosition cameraPosition = const NCameraPosition(
      target: NLatLng(37.506932467450326, 127.02578661133796),
      zoom: 7,
      bearing: 0,
      tilt: 0,
    );
    NaverMapController? naverMapController;
    Set<NMarker> markers = monthControl.monthDataList.where((element) {
      return element.gpsX != 0.0; // gpsX가 0.0이 아닌 요소만 필터링
      // 모든 element가 gpsX가 0.0이 아님을 보장.
    }).map((element) {
      final markers = NMarker(
        icon: const NOverlayImage.fromAssetImage("assets/marker.png"),
        id: element.id.toString(),
        position: NLatLng(element.gpsX ?? 0.0, element.gpsY ?? 0.0),);
      markers.setOnTapListener((overlay) =>monthControl.editSchedule(element, context));
      return markers;
    }).toSet();
    // 결과를 Set으로 변환
    return Scaffold(
      appBar: AppBar(title: "지도".text.make(),elevation: 0.0,centerTitle: true,),
      body: Column(
        children: [
          Expanded(
            child: NaverMap(
              options: NaverMapViewOptions(
                mapType:NMapType.basic,
                  zoomGesturesEnable: true,
                  nightModeEnable: true,
                  symbolScale: 1.2,
                  initialCameraPosition: cameraPosition),
              onMapTapped: (x, y) {},
              onMapReady: (controller1) {
                monthControl.monthDataList.map((element) {
                final onMarkerInfoWindow = NInfoWindow.onMarker(id: element.id.toString(), text: element.id.toString());
                markers.map((e) => e.openInfoWindow(onMarkerInfoWindow));
                });
                naverMapController = controller1;
                setState(() {
                  naverMapController!.addOverlayAll(markers);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
