// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
//
// import 'metting_class.dart';
//
// ///싱글톤 작성
// class LocalDB{
//
//   static late final Isar isar;
//   LocalDB._();
//
//   static LocalDB instance = LocalDB._();
//
//   static Future<void> init()async{
//     final dir = await getApplicationDocumentsDirectory();
//     isar = await Isar.open(
//       [MeetingSchema],
//       directory: dir.path,
//     );
//   }
//   Future<List<Meeting>> getTodoList() async{
//     final document = await isar.meetings.where().findAll();
//     return document.map((e) => e).toList();
//   }
//   Future<List<Meeting>> getSelectList(DateTime dateTime) async{
//     final document = await isar.meetings.where().idEqualTo(2).findAll();
//     print("document filter date ${dateTime}");
//     return document.map((e) => e).toList();
//   }
//   //{"background":4279451602,"eventName":"안녕 테스트","from":16952312400000000,"id":2,"isAllDay":false,"to":1695400440000000}
//
//
//   Future<void> addTodo(Meeting Meeting)async{
//     await isar.writeTxn(() async{
//       await isar.meetings.put(Meeting);
//     });
//   }
//   Future<void> delete(Id id)async{
//     await isar.writeTxn(()async{
//       await isar.meetings.delete(id);
//     });
//   }
//   Future<void> updateMemo(Meeting Meeting)async{
//     await isar.writeTxn(()async{
//       await isar.meetings.put(Meeting);
//     });
//   }
// }