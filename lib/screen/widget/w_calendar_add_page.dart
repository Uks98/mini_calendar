import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:after_layout/after_layout.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/widget/w_custom_datePicker.dart';
import 'package:today_my_calendar/screen/widget/w_memo_container_widget.dart';
import 'package:today_my_calendar/screen/widget/w_quick_fix_picker_time.dart';
import '../../common/widget/mixin/init_screen_size_utill.dart';
import '../../controller/alarm_setting_controller.dart';
import '../../controller/date_picker_controller.dart';
import '../../controller/map_data_controller.dart';
import '../calendar/s_color_select_page.dart';
import 'w_location_search_widget.dart';
import 'alarm_setting_tile.dart';

class CalendarAddPage extends StatefulWidget {
  final Schedule? scheduleForEdit;
  Schedule schedule;
  bool isShowMap;

  CalendarAddPage(
      {super.key,
      this.scheduleForEdit,
      required this.schedule,
      required this.isShowMap});

  @override
  State<CalendarAddPage> createState() => _CalendarAddPageState();
}

class _CalendarAddPageState extends State<CalendarAddPage>
    with AfterLayoutMixin, ScreenInit {
  final double _textFieldWidth = 350;
  final double _textFieldHeight = 350;
  final double _quickWidgetLeftPadding = 290;
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();
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
  int _colorIndex = 0;

  bool get isOnMap => outPageGpsX != 0.0 ? true : false;

  RxBool get isShowStartPicker =>
      datePickerStateController.isShowStartDatePicker;

  RxBool get isShowLastPicker => datePickerStateController.isShowLastDatePicker;
  final alarmSet = Get.put(AlarmSettingController());
  NaverMapController? naverMapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.schedule.title.toString();
    _memoController.text = widget.schedule.memo.toString();
    datePickerStateController.startSelectedTime.value = widget.schedule.from;
    datePickerStateController.lastSelectedTime.value = widget.schedule.to;
    outPageGpsX = widget.schedule.gpsY!;
    outPageGpsY = widget.schedule.gpsX!;
    outPagePlace = widget.schedule.myPlace;
    _colorIndex = widget.schedule.colorIndex;

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
      appBar: AppBar(),
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
                Height(addPageHeight),

                ///색상
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "색상".text.size(normalFontSize).make(),
                    SizedBox(
                      width: smallWidth,
                    ),
                    Tap(
                      onTap: () async {
                        final corIndex = await customBottomSheet
                            .showCustomBottomSheet(context,
                                radius: 20.0.w, title: "이벤트 색상");
                        _colorIndex = corIndex;
                        setState(() {});
                      },
                      child: Obx(
                        () => Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: colorController.colorList[_colorIndex!],
                            borderRadius: BorderRadius.circular(smallHeight),
                          ),
                        ).pOnly(right: bigWidth),
                      ),
                    ),
                  ],
                ),
                Height(addPageHeight),

                ///시작 시간
                ShowDateStartPicker(
                  dateTime: DateTime.now(),
                  startText: "시작",
                  datePickerStateController: datePickerStateController,
                ),
                Height(addPageHeight),

                ///종료 시간
                ShowDateLastPicker(
                  dateTime: DateTime.now().add(Duration(hours: 1)),
                  startText: "종료",
                  datePickerStateController: datePickerStateController,
                ),
                Height(addPageHeight),
                ///시간 분 단위로 올리기
                QuickFixerDateWidget().pOnly(
                    top: middleHeight.h, left: _quickWidgetLeftPadding.w),

                ///알람 설정
                Height(addPageHeight),
                const AlarmSettingTile(),
                Height(addPageHeight),
                ///위치 받아오기
                GestureDetector(
                    onTap: () async {
                      var gps = await Get.to<Schedule>(LocationSearchWidget());
                      print("gps ${gps?.title}");
                      if (gps == null) {
                        gps = Schedule(
                          id: null,
                            title: '',
                            memo: '',
                            from: DateTime.now(),
                            to: DateTime.now(),
                            myPlace: '',
                            gpsX: 0.0,
                            gpsY: 0.0,
                            colorIndex: 0);
                      } else {
                        outPageGpsX = gps.gpsX;
                        outPageGpsY = gps.gpsY;
                      }
                      outPagePlace = gps.myPlace; //?.
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "위치".text.size(normalFontSize).make(),
                        outPagePlace!.text
                            .size(bigFontSize)
                            .make()
                            .pOnly(left: smallWidth),
                      ],
                    )),
                Height(addPageHeight),
                ///네이버 맵

                if ((widget.schedule.gpsY != 0.0 ||
                        widget.schedule.gpsX != 0.0) ||
                    isOnMap == true)
                  showUserMap(),

                Height(addPageHeight),
                MemoContainer(textEditingController: _memoController,),
                IconButton(
                    onPressed: () {
                      try {
                        final lastTime =
                            datePickerStateController.lastSelectedTime.value;
                        alarmSet.getAlarmTime(
                            id: _titleController.text,
                            time: lastTime,
                            setTextTime: alarmSettingController.alarmTime.value,
                            context: context);
                        Navigator.of(context).pop(Schedule(
                          id: null,
                          title: _titleController.text,
                          memo: _memoController.text,
                          from:
                              datePickerStateController.startSelectedTime.value,
                          to: datePickerStateController.lastSelectedTime.value,
                          myPlace: outPagePlace.toString(),
                          gpsX: outPageGpsY,
                          gpsY: outPageGpsX,
                          colorIndex: _colorIndex,
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
                    icon: const Icon(Icons.check)),
              ],
            ).pOnly(left: 10.w),
          ),
        ));
  }

  Widget showUserMap() {
    if (mapDataController.isShowMap.value == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(middleWidth),
        child: Container(
          height: 200.h,
          width: MediaQuery.of(context).size.width - 80,
          child: NaverMap(
            options: NaverMapViewOptions(
                initialCameraPosition: _updateCameraPosition()),
            onMapReady: (controller) {
              naverMapController = controller;
              final marker = NMarker(
                  id: mapDataController.myPlace.value,
                  position: NLatLng(outPageGpsY!, outPageGpsX!));
              final onMarkerInfoWindow =
                  NInfoWindow.onMarker(id: "", text: outPagePlace.toString());
              controller.addOverlay(marker);
              marker.openInfoWindow(onMarkerInfoWindow);
              // print(mapDataController.isShowMap.value);
              _updateCameraPosition();
              setState(() {});
            },
          ),
        ),
      );
    }
    return Container();
  }
}
