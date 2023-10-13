import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

import '../../controller/map_data_controller.dart';

class LocationSearchWidget extends StatefulWidget {
  TextEditingController controller;
  LocationSearchWidget({super.key,required this.controller});

  @override
  State<LocationSearchWidget> createState() => _LocationSearchWidgetState();
}

class _LocationSearchWidgetState extends State<LocationSearchWidget> {
  MapDataController mapDataController = Get.put(MapDataController());
  TextEditingController get _locationController => widget.controller;
  @override
  void initState() {
      mapDataController.searchLocation(keyword:_locationController.text);
    mapDataController.getMapData(context, _locationController.text);
      if(_locationController.text.isEmpty){
        mapDataController.isShowMap.value = false;
      }

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  Widget build(BuildContext context) {
    final containerHeight = mapDataController.autoCompleteList.isEmpty ? 100.h : 300.h;
    return Container(
       height: containerHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              "위치".text.size(bigFontSize).make().pOnly(right: 4),
              Container(
                width: 200.w,
                child: TextField(
                  onTap: (){
                    _locationController.clear();
                    mapDataController.autoCompleteList.clear();
                    mapDataController.isShowMap.value = false;
                  },
                  onChanged: (value){
                       mapDataController.searchLocation(keyword: value);
                     mapDataController.getMapData(context, value);
                  },
                  style: TextStyle(fontSize: normalFontSize + 2),
                  // 폰트 크기를 20으로 설정
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    border: InputBorder.none, // 하단 밑줄 없애기
                    hintText: '위치',
                  ),
                  controller: _locationController,
                ).w(200),
              ),

            ],
          ),
          Obx(() => mapDataController.autoCompleteList.isNotEmpty ? Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final mapData = mapDataController.autoCompleteList[index];
                  return GestureDetector(
                    onTap: (){
                      if(_locationController.text.isNotEmpty){
                        mapDataController.myPlace.value = mapData.placeName;
                        _locationController.text = mapDataController.myPlace.value;
                        ///x y 좌표 적용
                        mapDataController.gpsX.value = double.parse(mapData.gpsX);
                        mapDataController.gpsY.value = double.parse(mapData.gpsY);
                        setState(() {
                          mapDataController.isShowMap.value = true;
                          //mapDataController.startLoading();
                        });
                      }

                      if(_locationController.text.isEmpty){
                        setState(() {
                        mapDataController.isShowMap.value = false;
                        });
                      }
                      print(mapDataController.isShowMap.value);
                    },
                    child: Card(
                      elevation: 1,
                      color: AppColors.darkGrey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mapData.placeName.text.size(normalFontSize).make(),
                          mapData.address.text
                              .size(smallFontSize)
                              .color(AppColors.brightGrey)
                              .make()
                        ],
                      ).paddingAll(smallHeight + 2.h),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Height(smallHeight);
                },
                itemCount: mapDataController.autoCompleteList.length,
              ).pOnly(left:smallWidth),
          ) : Container()
          ),
        ],
      ),
    );
  }
}
