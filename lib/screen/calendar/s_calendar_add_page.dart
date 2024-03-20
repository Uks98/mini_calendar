import 'package:flutter/material.dart';
import 'package:flutter_adfit/flutter_adfit.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/widget/w_custom_datePicker.dart';
import 'package:today_my_calendar/screen/widget/w_memo_container_widget.dart';
import 'package:today_my_calendar/screen/widget/w_quick_fix_picker_time.dart';
import '../../AD/w_adfit_box.dart';
import '../../common/widget/mixin/init_screen_size_utill.dart';
import '../../controller/alarm_setting_controller.dart';
import '../../controller/date_picker_controller.dart';
import '../../controller/map_data_controller.dart';
import 'calendar_memo_page.dart';
import 's_color_select_page.dart';
import '../widget/w_location_search_widget.dart';
import '../widget/alarm_setting_tile.dart';

class CalendarAddPage extends StatefulWidget {
  final Schedule? scheduleForEdit;
  Schedule schedule;
  bool isShowMap;
  bool initShowDetail; //페이지 상세보기

  CalendarAddPage(
      {super.key,
        this.scheduleForEdit,
        required this.schedule,
        required this.isShowMap,
        required this.initShowDetail
      });

  @override
  State<CalendarAddPage> createState() => _CalendarAddPageState();
}

class _CalendarAddPageState extends State<CalendarAddPage>
    with ScreenInit {
  final double _textFieldWidth = 350;
  final double _quickWidgetLeftPadding = 290;
  final _titleController = TextEditingController();
  final node = FocusNode();

  //controller
  DatePickerStateController datePickerStateController =
  Get.put(DatePickerStateController());
  AlarmSettingController alarmSettingController =
  Get.put(AlarmSettingController());
  AlarmSettingController alarmController = Get.put(AlarmSettingController());
  MapDataController mapDataController = Get.put(MapDataController());
  double? outPageGpsX = 0.0;
  double? outPageGpsY = 0.0;
  String? outPagePlace = "";
  String? memoText;
  int _colorIndex = 0; //색상 선택 인덱스
  bool isAllDay = false; //일정 하루종일?
  int get newId => DateTime.now().microsecondsSinceEpoch;
  bool isShowDetail = false; //add page 더보기 버튼
  bool get isOnMap => outPageGpsX != 0.0 ? true : false;
  set isOnMap(bool value) {
    value = widget.isShowMap;
  }
  RxBool get isShowStartPicker =>
      datePickerStateController.isShowStartDatePicker;

  RxBool get isShowLastPicker => datePickerStateController.isShowLastDatePicker;
  final alarmSet = Get.put(AlarmSettingController());
  NaverMapController? naverMapController;

  ///업데이트에 필요한 데이터 불러와서 대입
  void initDataForEdit(){
    _titleController.text = widget.schedule.title.toString();
    memoText = widget.schedule.memo.toString();
    datePickerStateController.startSelectedTime.value = widget.schedule.from!;
    datePickerStateController.lastSelectedTime.value = widget.schedule.to!;
    outPageGpsX = widget.schedule.gpsY!;
    outPageGpsY = widget.schedule.gpsX!;
    outPagePlace = widget.schedule.myPlace;
    _colorIndex = widget.schedule.colorIndex!;
    isOnMap = widget.isShowMap;
    isShowDetail = widget.initShowDetail;
    isAllDay = widget.schedule.isAllDay ?? false;
  }

  @override
  void initState() {
    super.initState();
    initDataForEdit();
    _updateCameraPosition();
  }

  @override
  void dispose() {
    super.dispose();
    naverMapController?.dispose();
    _titleController.dispose();
  }


  NCameraPosition _updateCameraPosition() {
    return NCameraPosition(
      target: NLatLng(outPageGpsY!, outPageGpsX!),
      zoom: 17,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>  FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                try {
                  if(_titleController.text.isNotEmpty){
                    final startTime = datePickerStateController.startSelectedTime.value;
                    alarmSet.getAlarmTime(
                      //id epoch 사용시 오류 발생
                      id: _titleController.text + newId.toString(),
                      time: startTime,
                      setTextTime: alarmSettingController.alarmTime.value,
                      context: context,
                      title: _titleController.text,
                      memo: memoText.toString(),
                    );
                    Navigator.of(context).pop(Schedule(
                      id: DateTime.now().microsecondsSinceEpoch,
                      title: _titleController.text,
                      memo: memoText.toString(),
                      from:
                      datePickerStateController.startSelectedTime.value,
                      to: datePickerStateController.lastSelectedTime.value,
                      myPlace: outPagePlace.toString(),
                      gpsX: outPageGpsY,
                      gpsY: outPageGpsX,
                      colorIndex: _colorIndex,
                      isShowMap: isOnMap,
                      isAllDay: isAllDay,
                    ));
                    FocusScope.of(context).unfocus();
                    datePickerStateController.isShowStartDatePicker.value =
                    false;

                    datePickerStateController.isShowLastDatePicker.value =
                    false;

                    alarmController.alarmTime.value = "없음";
                    naverMapController?.dispose();
                  }else if(_titleController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "제목을 입력해주세요".text.size(bigFontSize).make()));
                  return;
                  }

                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "일정을 작성하는데 잠시 문제가 발생했습니다.".text.size(bigFontSize).make()));
                }
              }, icon: const Icon(Icons.check))
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            color: context.backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      TextField(
                        style: TextStyle(fontSize: bigFontSize,fontWeight: FontWeight.w300), // 폰트 크기를 20으로 설정
                        decoration: const InputDecoration(
                          border: InputBorder.none, // 하단 밑줄 없애기
                          hintText: ' 제목',
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
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
                      "색상".text.size(normalFontSize).fontWeight(FontWeight.w300,).make().paddingOnly(left: 5.h),
                      SizedBox(
                        width: smallWidth,
                      ),
                      Tap(
                        onTap: () async {
                          final corIndex = await customBottomSheet
                              .showCustomBottomSheet(context,
                              radius: 10.0.w, title: "테마");
                          _colorIndex = corIndex;
                          setState(() {});
                        },
                        child: Obx(
                              () => Container(
                            width: 13.w,
                            height: 13.h,
                            decoration: BoxDecoration(
                              color: colorController.colorList.keys.elementAt(_colorIndex),
                              borderRadius: BorderRadius.circular(smallHeight-2),
                            ),
                          ).pOnly(right: bigWidth),
                        ),
                      ),
                    ],
                  ),
                  Height(addPageHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "하루 종일".text.size(normalFontSize).fontWeight(FontWeight.w300,).make().paddingOnly(left: 5.h),
                      SizedBox(
                        width: smallWidth,
                      ),
                      Switch(value: isAllDay, onChanged: (value){
                        setState(() {
                          isAllDay = value;
                        });
                      },activeColor: const Color(0xffBCA37F),).pOnly(right: normalWidth),
                    ],
                  ),
                  if(isAllDay == false)
                  Height(addPageHeight),
                  ///시작 시간
                  if(isAllDay == false)
                  ShowDateStartPicker(
                    //dateTime: DateTime.now(),
                    startText: "시작",
                    datePickerStateController: datePickerStateController,
                  ) ,
                  Height(addPageHeight),
                  if(isAllDay == false)
                  ///종료 시간
                  ShowDateLastPicker(
                    //dateTime: DateTime.now(),
                    startText: "종료",
                    datePickerStateController: datePickerStateController,
                  ),
                  Height(smallHeight),
                  if(isAllDay == false)
                  ///시간 분 단위로 올리기
                  QuickFixerDateWidget().pOnly(
                      top: normalHeight.h, left: _quickWidgetLeftPadding.w),
                  if(isAllDay == false)
                  Height(addPageHeight),
                  if(!isShowDetail)
                    Center(
                      child: IconButton(onPressed: ()=> setState(() {isShowDetail = true;}),icon: const Icon(Icons.arrow_drop_down),),
                    ),
                  if(isShowDetail == true)
                    Column(
                      children: [
                        ///알람 설정
                        if(isAllDay == false)
                        const AlarmSettingTile(),
                        if(isAllDay == false)
                        Height(addPageHeight),
                        ///위치 받아오기
                        GestureDetector(
                            onTap: () async {
                              var gps = await Get.to<Schedule>(LocationSearchWidget(schedule: Schedule(id: 0,gpsY: outPageGpsX,gpsX:outPageGpsY ),),);
                              if (gps == null) {
                                gps = Schedule(
                                  id: DateTime.now().microsecondsSinceEpoch,
                                  gpsX: 0.0,
                                  gpsY: 0.0,
                                  isShowMap: isOnMap,
                                );
                              } else {
                                outPageGpsX = gps.gpsX!;
                                outPageGpsY = gps.gpsY!;
                              }
                              outPagePlace = gps.myPlace; //?.
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                "위치".text.size(normalFontSize).fontWeight(FontWeight.w300,).make().paddingOnly(left: 4.w),
                                outPagePlace!.text
                                    .size(bigFontSize).fontWeight(FontWeight.w300,)
                                    .make()
                                    .pOnly(right: smallWidth + 2),
                              ],
                            )),
                        Height(addPageHeight),
                        ///네이버 맵
                        Height(addPageHeight),
                        showUserMap(),
                        //메모
                        //메모페이지로 이동
                        Height(bigHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "메모".text.size(normalFontSize).fontWeight(FontWeight.w300,).make().paddingOnly(left: 5.w),
                          ],
                        ),
                        Height(normalHeight),
                        moveToMemo(),
                        Height(30.h),
                        AdfitBox.adfitAdvertise(AdFitBannerSize.SMALL_BANNER),
                        Height(40.h),
                      ],
                    )

                ],
              ).pOnly(left: 10.w),
            ),
          )),
    );
  }

  //메모장으로 이동
  GestureDetector moveToMemo() {
    return GestureDetector(
        onTap: ()async{
          Schedule memos = await Get.to(MemoPage(memoText: Schedule(
            id: DateTime.now().microsecondsSinceEpoch,
            memo: memoText.toString(),
          ),
          ),);
          memoText = memos.memo;
          //naverMapController?.dispose();
          setState(() {});
        },
        child: MemoContainer(memoText: memoText!,)
    );
  }

  Widget showUserMap() {
    if ((widget.schedule.gpsY != 0.0 ||
        widget.schedule.gpsX != 0.0) ||
        isOnMap == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(normalWidth),
        child: SizedBox(
          height: 180.h,
          width: MediaQuery
              .of(context)
              .size
              .width - 80,
          child: NaverMap(
            options: NaverMapViewOptions(
                initialCameraPosition: _updateCameraPosition()),
            onMapReady: (controller) {
              naverMapController = controller;
              final marker = NMarker(
                  id: mapDataController.myPlace.value,
                  position: NLatLng(outPageGpsY!, outPageGpsX!));
              final onMarkerInfoWindow =
              NInfoWindow.onMarker(id: "1", text: outPagePlace.toString());
              naverMapController!.addOverlay(marker);
              marker.openInfoWindow(onMarkerInfoWindow);
              // print(mapDataController.isShowMap.value);
              _updateCameraPosition();
            },
          ),
        ),
      );
    }
    return Container();
  }
}