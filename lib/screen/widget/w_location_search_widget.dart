import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/app_colors.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/widget/w_calendar_add_page.dart';
import 'package:today_my_calendar/tab/s_calendar_month_page.dart';

import '../../controller/map_data_controller.dart';


class LocationSearchWidget extends StatefulWidget {
  LocationSearchWidget({super.key});

  @override
  State<LocationSearchWidget> createState() => _LocationSearchWidgetState();
}

class _LocationSearchWidgetState extends State<LocationSearchWidget> {
  MapDataController mapDataController = Get.put(MapDataController());
  double searchGpsX = 0.0;
  double searchGpsY = 0.0;
  double textFieldLeftPadding = 20.0;
  Schedule? schedule;
  final TextEditingController _locationController = TextEditingController();

  String searchPlace = "";

  @override
  void initState() {
      mapDataController.searchLocation(context: context,keyword:_locationController.text);
    mapDataController.getMapData(context, _locationController.text);

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _locationController.dispose();
  }
  Widget build(BuildContext context) {
    const containerHeight = 300.0;
    return Scaffold(
      appBar: AppBar(

        title: "위치".text.size(bigFontSize).make(),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
            //Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarAddPage(schedule: Schedule(title: '',memo: '',from: DateTime.now(),to: DateTime.now(),myPlace: "",gpsX: 0.0,gpsY: 0.0), isShowMap: false)));
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.search_outlined),
                Container(
                  width: 200.w,
                  child: TextField(
                    onTap: (){
                     // _locationController.clear();
                      mapDataController.autoCompleteList.clear();
                      mapDataController.isShowMap.value = false;
                    },
                    onChanged: (value){
                      mapDataController.searchLocation(context : context,keyword: value);
                    } ,
                    style: TextStyle(fontSize: normalFontSize + 2),
                    // 폰트 크기를 20으로 설정
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      border: InputBorder.none, // 하단 밑줄 없애기
                      hintText: '위치를 입력하세요.',
                      //hintStyle: TextStyle(color: )
                    ),
                    controller: _locationController,
                  ).w(200).pOnly(left: textFieldLeftPadding),
                ),
              ],
            ).pOnly(left: textFieldLeftPadding),
            Obx(() =>mapDataController.autoCompleteList.isNotEmpty ? SingleChildScrollView(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final mapData = mapDataController.autoCompleteList[index];
                    return GestureDetector(
                      onTap: (){
                          mapDataController.myPlace.value = mapData.placeName;
                          _locationController.text = mapDataController.myPlace.value;
                          ///x y 좌표 적용
                          searchGpsX = double.parse(mapData.gpsY); //gps x
                          searchGpsY = double.parse(mapData.gpsX); //gps y
                          searchPlace = mapData.placeName;
                          mapDataController.autoCompleteList.clear();
                            mapDataController.isShowMap.value = true;

                        if(_locationController.text.isEmpty){
                          mapDataController.isShowMap.value = false;
                        }
                        Navigator.of(context).pop(Schedule(
                            myPlace : searchPlace,gpsX: searchGpsY,gpsY: searchGpsX, title: '', memo: '', from: DateTime.now(), to: DateTime.now()));
                      },
                      child: Card(
                        elevation: 1,
                        color: AppColors.darkGrey,
                        child: Column(
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
            ) : Container()),
          ],
        ),
      ),
    );
  }
}
