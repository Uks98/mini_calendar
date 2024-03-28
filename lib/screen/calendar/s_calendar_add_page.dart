import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adfit/flutter_adfit.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:today_my_calendar/common/common.dart';
import 'package:today_my_calendar/common/constant/constant_widget.dart';
import 'package:today_my_calendar/common/widget/mixin/payment_mixin.dart';
import 'package:today_my_calendar/controller/repeat_controller.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';
import 'package:today_my_calendar/screen/widget/w_custom_datePicker.dart';
import 'package:today_my_calendar/screen/widget/w_memo_container_widget.dart';
import 'package:today_my_calendar/screen/widget/w_quick_fix_picker_time.dart';
import '../../AD/w_adfit_box.dart';
import '../../common/constant/app_colors.dart';
import '../../common/data/preference/prefs.dart';
import '../../common/widget/mixin/init_screen_size_utill.dart';
import '../../common/widget/repeat_tile/w_repeat_end_tile.dart';
import '../../common/widget/repeat_tile/w_repeat_tile.dart';
import '../../controller/alarm_setting_controller.dart';
import '../../controller/color_select_controller.dart';
import '../../controller/date_picker_controller.dart';
import '../../controller/map_data_controller.dart';
import '../../controller/month_data_controller.dart';
import 'calendar_memo_page.dart';
import 's_color_select_page.dart';
import '../widget/w_location_search_widget.dart';
import '../widget/alarm_setting_tile.dart';

class CalendarAddPage extends StatefulWidget {
  final Schedule? scheduleForEdit;
  Schedule schedule;
  bool? isShowMap;
  bool? initShowDetail; //페이지 상세보기

  CalendarAddPage(
      {super.key,
      this.scheduleForEdit,
      required this.schedule,
      required this.isShowMap,
      required this.initShowDetail});

  @override
  State<CalendarAddPage> createState() => _CalendarAddPageState();
}

class _CalendarAddPageState extends State<CalendarAddPage>
    with
        ScreenInit,
        PaymentShowSheet,
        MonthControllerMix,
        RepeatControllerMixin {
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
  final ColorSelectController _colorBox = Get.put(ColorSelectController());

  double? outPageGpsX = 0.0;
  double? outPageGpsY = 0.0;
  String outPagePlace = "";
  String? memoText;
  String? _alarmSettingText;

  /// 알람을 정한 시간 (지정시간,5분전,,,)
  int _colorIndex = 0; //색상 선택 인덱스
  bool isAllDay = false; //일정 하루종일?
  bool isEndRepeat = false; //반복일정의 datepicker 보여줄 것인지
  int get newId => DateTime.now().microsecondsSinceEpoch; //id
  bool isShowDetail = false; //add page 더보기 버튼
  bool get isOnMap => outPageGpsX != 0.0 ? true : false;
  bool isSizedBox = false;

  set isOnMap(bool? value) {
    value = widget.isShowMap;
  }

  bool get isLightModes => Prefs.isLightModes.get(); //다크모드 ? 라이트모드
  RxBool get isShowStartPicker =>
      datePickerStateController.isShowStartDatePicker;

  RxBool get isShowLastPicker => datePickerStateController.isShowLastDatePicker;
  final alarmSet = Get.put(AlarmSettingController());
  NaverMapController? naverMapController;

  ///업데이트에 필요한 데이터 불러와서 대입
  void initDataForEdit() {
    _titleController.text = widget.schedule.title.toString();
    memoText = widget.schedule.memo.toString();
    datePickerStateController.startSelectedTime.value = widget.schedule.from!;
    datePickerStateController.lastSelectedTime.value = widget.schedule.to!;
    outPageGpsX = widget.schedule.gpsY ?? 0.0;
    outPageGpsY = widget.schedule.gpsX ?? 0.0;
    outPagePlace = widget.schedule.myPlace ?? "없음";
    _colorIndex = widget.schedule.colorIndex!;
    isOnMap = widget.isShowMap ?? false;
    isShowDetail = widget.initShowDetail ?? false;
    isAllDay = widget.schedule.isAllDay ?? false;
    _alarmSettingText = widget.schedule.alarmSetText;
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
    //alarmSettingController.alarmTime.value = widget.schedule.alarmSetText!;
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            actions: [
              widget.schedule.title != "" ? IconButton(onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('일정 삭제'),
                      content: Text('이 일정을 삭제하시겠습니까?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('아니오'),
                          onPressed: () {
                            Navigator.of(context).pop(); // 팝업창 닫기
                          },
                        ),
                        TextButton(
                          child: const Text('일정 삭제',style: TextStyle(color: Colors.redAccent),),
                          onPressed: () {
                            monthControl.deleteSchedule(widget.schedule); // 일정 삭제 실행
                            Get.back();
                            Get.back();
                          },
                        ),
                      ],
                    );
                  },
                );
              }, icon: const Icon(EvaIcons.trashOutline,color: Colors.redAccent,)):SizedBox(),
              WidthBox(bigWidth),
              IconButton(
                  onPressed: () {
                    if (outPagePlace != "") {
                      isOnMap = true;
                    } else {
                      isOnMap = false;
                    }
                    try {
                      _alarmSettingText =
                          alarmSettingController.alarmTime.value;
                      if (_titleController.text.isNotEmpty) {
                        final lastTime =
                            datePickerStateController.lastSelectedTime.value;
                        alarmSet.getAlarmTime(
                          //id epoch 사용시 오류 발생
                          id: _titleController.text + newId.toString(),
                          time: lastTime,
                          setTextTime: _alarmSettingText!,
                          //알람오류원인 x
                          context: context,
                          title: _titleController.text,
                          memo: memoText.toString(),
                        );
                        Navigator.of(context).pop(
                          Schedule(
                            id: DateTime.now().microsecondsSinceEpoch,
                            title: _titleController.text,
                            memo: memoText.toString(),
                            from: datePickerStateController
                                .startSelectedTime.value,
                            to: datePickerStateController
                                .lastSelectedTime.value,
                            myPlace: outPagePlace.toString(),
                            gpsX: outPageGpsY,
                            gpsY: outPageGpsX,
                            colorIndex: _colorIndex,
                            isShowMap: isOnMap,
                            isAllDay: isAllDay,
                            alarmSetText: _alarmSettingText,
                          ),
                        );
                        FocusScope.of(context).unfocus();

                        datePickerStateController.isShowStartDatePicker.value =
                            false;
                        datePickerStateController.isShowLastDatePicker.value =
                            false;
                        // alarmSettingController.alarmTime.value = "없음";
                        naverMapController?.dispose();
                      } else if (_titleController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                "제목을 입력해주세요".text.size(bigFontSize).make()));
                        return;
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: "일정을 작성하는데 문제가 발생했습니다."
                              .text
                              .size(bigFontSize)
                              .make(),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.check))
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            color: context.backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextField(
                            style: TextStyle(
                                fontSize: bigFontSize,
                                fontWeight: FontWeight.w300), // 폰트 크기를 20으로 설정
                            onChanged: (value) {
                              monthControl.searchTitleList(keyword: value, context: context);
                              if (value.isEmpty) {
                                isSizedBox = false;
                                monthControl.monthSearchList.clear();
                                _titleController.clear();
                              }
                              setState(() {});
                            },
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
                      Obx(
                        () => monthControl.monthSearchList.isEmpty
                            ? Container(
                                color: Colors.red,
                              )
                            : SizedBox(
                                height: 50.h,
                                width: 600.w,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    final search = monthControl.monthSearchList[index];
                                    return GestureDetector(
                                        onTap: () {
                                          _titleController.text = search.title.toString();
                                          memoText = search.memo.toString();
                                          outPageGpsX = search.gpsY;
                                          outPageGpsY = search.gpsX;
                                          outPagePlace = search.myPlace ?? "없음";
                                          _colorIndex = search.colorIndex ?? 0;
                                          isOnMap = search.isShowMap ?? false;
                                          isShowDetail = search.isShowMap ?? false;
                                          isAllDay = search.isAllDay ?? false;
                                          datePickerStateController.startSelectedTime.value = search.from!;
                                          datePickerStateController.lastSelectedTime.value = search.to!;
                                          setState(() {});
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: isLightModes
                                                    ? AppColors.darkGrey
                                                    : context.appColors
                                                        .settingListColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        smallWidth)),
                                            child: Row(
                                              children: [
                                                Width(smallWidth),
                                                VxBox()
                                                    .width(3.w)
                                                    .height(40.h)
                                                    .withRounded(value: 2.w)
                                                    .color(_colorBox
                                                        .colorList.keys
                                                        .elementAt(
                                                            search.colorIndex ??
                                                                0))
                                                    .make(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 80.w,
                                                      child: search.title!.text
                                                          .size(bigFontSize)
                                                          .fontWeight(
                                                              FontWeight.w300)
                                                          .overflow(TextOverflow
                                                              .ellipsis)
                                                          .color(isLightModes
                                                              ? Colors.white
                                                              : context
                                                                  .appColors
                                                                  .text)
                                                          .make(),
                                                    ),
                                                    " ${search.to!.year}년 ${search.from!.month}월 ${search.from!.day}일 ${search.to!.hour < 12 ? "오전" : "오후"} ${search.from!.hour}시 ${search.from!.minute}분  ~ "
                                                            " ${returnToMonDay(search.from!.month, search.to!.month, search.from!.day, search.to!.day, search.to!.hour, search.to!.minute)}"
                                                        .text
                                                        .size(smallFontSize)
                                                        .color(isLightModes
                                                            ? Colors.white
                                                            : Colors.black)
                                                        .make(),
                                                  ],
                                                ).paddingAll(smallHeight.h),
                                              ],
                                            ),).paddingOnly(left: smallWidth),);
                                  },
                                  itemCount:
                                      monthControl.monthSearchList.length,
                                )),
                      )
                    ],
                  ),
                  Height(addPageHeight),

                  ///색상
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "색상"
                          .text
                          .size(normalFontSize)
                          .fontWeight(
                            FontWeight.w300,
                          )
                          .make()
                          .paddingOnly(left: 5.h),
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
                              color: colorController.colorList.keys
                                  .elementAt(_colorIndex),
                              borderRadius:
                                  BorderRadius.circular(smallHeight - 2),
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
                      "하루 종일"
                          .text
                          .size(normalFontSize)
                          .fontWeight(
                            FontWeight.w300,
                          )
                          .make()
                          .paddingOnly(left: 5.h),
                      SizedBox(
                        width: smallWidth,
                      ),
                      Switch(
                        value: isAllDay,
                        onChanged: (value) {
                          setState(() {
                            isAllDay = value;
                          });
                        },
                        activeColor: const Color(0xffBCA37F),
                      ).pOnly(right: normalWidth),
                    ],
                  ),
                  if (isAllDay == false) Height(addPageHeight),

                  ///시작 시간
                  if (isAllDay == false)
                    ShowDateStartPicker(
                      //dateTime: DateTime.now(),
                      startText: "시작",
                      datePickerStateController: datePickerStateController,
                    ),
                  Height(addPageHeight),
                  if (isAllDay == false)

                    ///종료 시간
                    ShowDateLastPicker(
                      //dateTime: DateTime.now(),
                      startText: "종료",
                      datePickerStateController: datePickerStateController,
                    ),
                  Height(smallHeight),
                  if (isAllDay == false)

                    ///시간 분 단위로 올리기
                    QuickFixerDateWidget().pOnly(
                        top: normalHeight.h, left: _quickWidgetLeftPadding.w),
                  if (isAllDay == false) Height(addPageHeight),
                  if (!isShowDetail)
                    Center(
                      child: IconButton(
                        onPressed: () => setState(() {
                          isShowDetail = true;
                        }),
                        icon: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  if (isShowDetail == true)
                    Column(
                      children: [
                        ///알람 설정
                        if (isAllDay == false)
                          AlarmSettingTile(alarmInitText: _alarmSettingText),
                        if (isAllDay == false) Height(addPageHeight),

                        ///위치 받아오기
                        GestureDetector(
                          onTap: () async {
                            var gps = await Get.to<Schedule>(
                              LocationSearchWidget(
                                schedule: Schedule(
                                    id: 0,
                                    gpsY: outPageGpsX,
                                    gpsX: outPageGpsY),
                              ),
                            );
                            if (gps == null) {
                              gps = Schedule(
                                id: DateTime.now().microsecondsSinceEpoch,
                                gpsX: 0.0,
                                gpsY: 0.0,
                                isShowMap: isOnMap,
                              );
                            } else {
                              outPageGpsX = gps.gpsX ?? 0.0;
                              outPageGpsY = gps.gpsY ?? 0.0;
                            }
                            outPagePlace = gps.myPlace ?? ""; //?.
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: "위치"
                                    .text
                                    .size(normalFontSize)
                                    .fontWeight(
                                      FontWeight.w300,
                                    )
                                    .make()
                                    .paddingOnly(left: 4.w),
                              ),
                              outPagePlace.text
                                  .size(bigFontSize)
                                  .fontWeight(
                                    FontWeight.w300,
                                  )
                                  .make()
                                  .pOnly(right: smallWidth + 2),
                            ],
                          ),
                        ),
                        Height(addPageHeight),

                        ///네이버 맵
                        Height(addPageHeight),
                        widget.schedule.isShowMap == true
                            ? showUserMap()
                            : const SizedBox(),
                        //메모
                        //메모페이지로 이동
                        Height(bigHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "메모"
                                .text
                                .size(normalFontSize)
                                .fontWeight(
                                  FontWeight.w300,
                                )
                                .make()
                                .paddingOnly(left: 5.w),
                          ],
                        ),
                        Height(normalHeight),
                        moveToMemo(),
                        Height(30.h),
                        AdfitBox.adfitAdvertise(AdFitBannerSize.SMALL_BANNER,
                            () => showPaymentSheet(context)),
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
        onTap: () async {
          Schedule? memos = await Get.to(
            MemoPage(
              memoText: Schedule(
                id: DateTime.now().microsecondsSinceEpoch,
                memo: memoText ?? "",
              ),
            ),
          );

          memoText = memos?.memo ?? "";
          setState(() {});
        },
        child: MemoContainer(
          memoText: memoText ?? "",
        ));
  }

  Widget showUserMap() {
    if ((widget.schedule.gpsY != 0.0 || widget.schedule.gpsX != 0.0) ||
        isOnMap == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(normalWidth),
        child: SizedBox(
          height: 180.h,
          width: MediaQuery.of(context).size.width - 80,
          child: NaverMap(
            options: NaverMapViewOptions(
                initialCameraPosition: _updateCameraPosition()),
            onMapReady: (controller) {
              naverMapController = controller;
              final marker = NMarker(
             icon: const NOverlayImage.fromAssetImage("assets/circle.png"),
                  id: mapDataController.myPlace.value,
                  position: NLatLng(outPageGpsY!, outPageGpsX!));
              final onMarkerInfoWindow = NInfoWindow.onMarker(id: marker.info.id, text: outPagePlace.toString());
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
