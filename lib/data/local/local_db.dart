import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:today_my_calendar/screen/calendar/calendar_data/d_schedule_data.dart';


class LocalDB{

  static late final Isar isar;
  LocalDB._();

  static LocalDB instance = LocalDB._();

  static Future<void> init()async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ScheduleSchema],
      directory: dir.path,
    );
  }
  Future<List<Schedule>> getTodoList() async{
    final document = await isar.schedules.where().findAll();
    return document.map((e) => e).toList();
  }
  Future<List<Schedule>> getSelectList(DateTime dateTime) async{
    final document = await isar.schedules.where().idEqualTo(2).findAll();
    return document.map((e) => e).toList();
  }
  //{"background":4279451602,"eventName":"안녕 테스트","from":16952312400000000,"id":2,"isAllDay":false,"to":1695400440000000}


  Future<void> addDBSchedule(Schedule schedule)async{
    await isar.writeTxn(() async{
      await isar.schedules.put(schedule);
    });
  }
  Future<void> deleteDBSchedule(Id id)async{
    await isar.writeTxn(()async{
      await isar.schedules.delete(id);
    });
  }
  Future<void> updateDBSchedule(Schedule schedule)async{
    await isar.writeTxn(()async{
      await isar.schedules.put(schedule);
    });
  }
}