
import 'package:isar/isar.dart';

part 'd_schedule_data.g.dart';

@collection
class Schedule {
  Schedule(
      {required this.id,
        this.title,
        this.memo,
        this.from,
        this.to,
        this.myPlace,
        this.gpsX,
        this.gpsY,
        this.colorIndex,
        this.isShowMap,
        this.isAllDay,
        this.alarmSetText
       // required this.eventColor,
        });
 @Index(type: IndexType.value)
 Id id;
 @Index(type: IndexType.value)
 String? title;
  ///간단한 메모
 @Index(type: IndexType.value)
 String? memo;
  ///시작시간
 @Index(type: IndexType.value)
 DateTime? from;
  ///끝나는 시간
 @Index(type: IndexType.value)
 DateTime? to;
  ///위치 선택시 내 위치
 @Index(type: IndexType.value)
 String? myPlace;
 ///gps x
 @Index(type: IndexType.value)
 double? gpsX;

 @Index(type: IndexType.value)
 double? gpsY;

 @Index(type: IndexType.value)
 int? colorIndex = 0;
 @Index(type: IndexType.value)
  bool? isShowMap = false;
 @Index(type: IndexType.value)
  bool? isAllDay = false;
  @Index(type: IndexType.value)
  String? alarmSetText;
}