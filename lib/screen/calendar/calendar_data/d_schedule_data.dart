
import 'package:isar/isar.dart';

part 'd_schedule_data.g.dart';

@collection
class Schedule {
  Schedule(
      {required this.id,
        required this.title,
        required this.memo,
        required this.from,
        required this.to,
        required this.myPlace,
        required this.gpsX,
        required this.gpsY,
        required this.colorIndex,
       // required this.eventColor,
        });
 @Index(type: IndexType.value)
 Id? id = Isar.autoIncrement;
 @Index(type: IndexType.value)
 String title;
  ///간단한 메모
 @Index(type: IndexType.value)
 String memo;
  ///시작시간
 @Index(type: IndexType.value)
 DateTime from;
  ///끝나는 시간
 @Index(type: IndexType.value)
 DateTime to;
  ///위치 선택시 내 위치
 @Index(type: IndexType.value)
 String myPlace;
 ///gps x
 @Index(type: IndexType.value)
 double? gpsX;

 @Index(type: IndexType.value)
 double? gpsY;

 @Index(type: IndexType.value)
 int colorIndex = 0;
}