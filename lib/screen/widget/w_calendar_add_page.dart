import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:after_layout/after_layout.dart';
import 'package:quiver/pattern.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/widget/w_custom_datePicker.dart';
import 'package:today_my_calendar/screen/widget/w_quick_fix_picker_time.dart';
import 'package:today_my_calendar/screen/widget/w_rounded_container.dart';
import '../../common/widget/mixin/init_screen_size_utill.dart';
import '../../common/widget/scaffold/bottom_dialog_scaffold.dart';
import '../../controller/alarm_setting_controller.dart';
import '../../controller/date_picker_controller.dart';
import '../../controller/map_data_controller.dart';
import '../../tab/s_calendar_month_page.dart';
import 'w_location_search_widget.dart';
import 'alarm_setting_tile.dart';

class CalendarAddPage extends StatefulWidget {
  final Schedule? scheduleForEdit;
  Schedule schedule;
  bool isShowMap;
  CalendarAddPage({super.key, this.scheduleForEdit,required this.schedule,required this.isShowMap});

  @override
  State<CalendarAddPage> createState() => _CalendarAddPageState();
}

class _CalendarAddPageState extends State<CalendarAddPage>
    with AfterLayoutMixin, ScreenInit {
  final double _textFieldWidth = 350;
  final double _textFieldHeight = 350;
  final double _quickWidgetLeftPadding = 270;
  final _titleController = TextEditingController();
  final node = FocusNode();

  //controller
  DatePickerStateController datePickerStateController =
  Get.put(DatePickerStateController());
  AlarmSettingController alarmSettingController =
  Get.put(AlarmSettingController());
  MapDataController mapDataController = Get.put(MapDataController());
  double? outPageGpsX = 0.0;
  double? outPageGpsY = 0.0;
  String? outPagePlace = "";
  bool get isOnMap=> outPageGpsX != 0.0 ? true : false;

  RxBool get isShowStartPicker => datePickerStateController.isShowStartDatePicker;

  RxBool get isShowLastPicker => datePickerStateController.isShowLastDatePicker;
  final alarmSet = Get.put(AlarmSettingController());
  NaverMapController? naverMapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.schedule.title.toString();
    datePickerStateController.startSelectedTime.value = widget.schedule.from;
    datePickerStateController.lastSelectedTime.value = widget.schedule.to;
    outPageGpsX = widget.schedule.gpsY!;
    outPageGpsY = widget.schedule.gpsX!;
    outPagePlace = widget.schedule.myPlace;
    _updateCameraPosition();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    naverMapController?.dispose();
    _titleController.dispose();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    throw UnimplementedError();
  }

  NCameraPosition _updateCameraPosition() {
    return NCameraPosition(
      target: NLatLng(outPageGpsY!, outPageGpsX!),
      zoom: 17,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: context.backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextField(
                      autocorrect: false,
                      //focusNode: node,
                      style: TextStyle(fontSize: bigFontSize), // 폰트 크기를 20으로 설정
                      decoration: const InputDecoration(
                        border: InputBorder.none, // 하단 밑줄 없애기
                        hintText: '제목',
                      ),
                      controller: _titleController,
                    ).w(_textFieldWidth),
                    spacer,
                  ],
                ),

                ///시작 시간
                ShowDateStartPicker(
                  dateTime: DateTime.now(),
                  startText: "시작",
                  datePickerStateController: datePickerStateController,
                ),

                ///종료 시간
                ShowDateLastPicker(
                  dateTime: DateTime.now(),
                  startText: "종료",
                  datePickerStateController: datePickerStateController,
                ),

                ///시간 분 단위로 올리기
                QuickFixerDateWidget()
                    .pOnly(
                    top: middleHeight.h, left: _quickWidgetLeftPadding.w),

                ///알람 설정
                Height(middleHeight),
                const AlarmSettingTile(),
                Height(middleHeight),
                ///위치 받아오기
                GestureDetector(
                    onTap: ()async{
                      final gps =  await Get.to<Schedule>(LocationSearchWidget());
                      if(gps != null){
                        outPageGpsX = gps.gpsX ?? 0.0;
                        outPageGpsY = gps.gpsY ?? 0.0;
                      }
                      outPagePlace = gps?.myPlace;
                      print("is on map${isOnMap}");
                      setState(() {});
                    } ,
                    child: Row(
                      children: [
                        "위치".text.make(),
                        outPagePlace!.text.size(bigFontSize).make().pOnly(right: 4),
                      ],
                    )),


                ///네이버 맵

                //mapDataController.isShowMap.value == true && widget.isShowMap == true
                if((widget.schedule.gpsY != 0.0 || widget.schedule.gpsX != 0.0) || isOnMap == true)
                  showUserMap(),
                // Center(
                //   child: Container(
                //     width: 300,
                //     height: 200,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: TextField(
                //       decoration: InputDecoration(
                //         hintText: 'Enter text',
                //         border: InputBorder.none,
                //         contentPadding:
                //         EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                //       ),
                //     ),
                //   ),
                // ),
                Height(5),
                IconButton(
                    onPressed: () {
                      try {
                        final lastTime = datePickerStateController
                            .lastSelectedTime.value;
                        alarmSet.getAlarmTime(id: _titleController.text,
                            time: lastTime,
                            setTextTime: alarmSettingController.alarmTime.value,
                            context: context);
                        Navigator.of(context).pop(Schedule(
                          title: _titleController.text,
                          memo: "abc",
                          from: datePickerStateController.startSelectedTime
                              .value,
                          to: datePickerStateController.lastSelectedTime.value,
                          myPlace: mapDataController.myPlace.value,
                          gpsX: outPageGpsY,
                          gpsY: outPageGpsX,
                        ));
                        datePickerStateController.isShowStartDatePicker.value =
                        false;
                        datePickerStateController.isShowLastDatePicker.value =
                        false;
                        naverMapController?.dispose();
                      } catch (E) {
                        print(E);
                      }
                    },
                    icon: Icon(Icons.check))
              ],
            ).pOnly(left: 10.w),
          ),
        ));
  }

  Widget showUserMap() {
    if(mapDataController.isShowMap.value == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(middleWidth),
        child: Container(
          height: 200.h,
          width: MediaQuery
              .of(context)
              .size
              .width - 80,
          child: NaverMap(
            options: NaverMapViewOptions(
                initialCameraPosition: _updateCameraPosition()
            ),
            onMapReady: (controller) {
              naverMapController = controller;
              final marker = NMarker(
                  id: mapDataController.myPlace.value,
                  position: NLatLng(outPageGpsY!,outPageGpsX!));
              final onMarkerInfoWindow =
              NInfoWindow.onMarker(id: "", text: outPagePlace.toString());
              controller.addOverlay(marker);
              marker.openInfoWindow(onMarkerInfoWindow);
            // print(mapDataController.isShowMap.value);
              _updateCameraPosition();
              setState(() { });
            },
          ),
        ),
      );
    }
    return Container();
  }
}