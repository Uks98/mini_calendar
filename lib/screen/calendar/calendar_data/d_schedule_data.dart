class Schedule {
  Schedule(
      {required this.title,
        required this.memo,
        required this.from,
        required this.to,
        required this.myPlace,
        required this.gpsX,
        required this.gpsY,
        required this.colorIndex,
       // required this.eventColor,
        });

 String title;
  ///간단한 메모
  String memo;
  ///시작시간
  DateTime from;
  ///끝나는 시간
  DateTime to;
  ///위치 선택시 내 위치
 String myPlace;
 ///gps x
 double? gpsX;
 double? gpsY;
 int colorIndex = 0;
}