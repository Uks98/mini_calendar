

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';

import '../../controller/map_data_controller.dart';

class LocationSearchWidget extends StatefulWidget {
  const LocationSearchWidget({Key? key}) : super(key: key);

  @override
  State<LocationSearchWidget> createState() => _LocationSearchWidgetState();
}

class _LocationSearchWidgetState extends State<LocationSearchWidget> {
  MapDataController mapDataController = Get.put(MapDataController());
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      child: Column(
        children: [
          Row(
            children: [
              "위치".text.size(bigFontSize).make().pOnly(right: 4),
              TextField(
                style: TextStyle(fontSize: normalFontSize+2), // 폰트 크기를 20으로 설정
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  border: InputBorder.none, // 하단 밑줄 없애기
                  hintText: '위치',
                ),
                controller: searchController,
              ).w(200),
            ],
          ),
          Expanded(
              child: ListView.separated(itemBuilder: (context,index){
            final mapData = mapDataController.mapList[index];
            return Card(
              color: AppColors.darkGrey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mapData.placeName.text.size(normalFontSize).make(),
                  mapData.address.text.size(smallFontSize).color(AppColors.brightGrey).make()
                ],
              ),
            ).paddingAll(3);
          }, separatorBuilder: (BuildContext context, int index) {
            return Height(smallHeight);
          }, itemCount: mapDataController.mapList.length,))
        ],
      ),
    );
  }
}
