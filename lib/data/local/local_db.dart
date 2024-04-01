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
  Future<List<Schedule>> getScheduleList() async{
    final document = await isar.schedules.where().isTemplateEqualTo(false).findAll();
    return document.map((e) => e).toList();
  }
  Future<List<Schedule>> getTemplateList() async{
    final document = await isar.schedules.where().isTemplateEqualTo(true).findAll();
    return document.map((e) => e).toList();
  }
  Future<List<Schedule>> getSelectList(DateTime dateTime) async{
    final document = await isar.schedules.where().idEqualTo(2).findAll();
    return document.map((e) => e).toList();
  }


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