

import 'package:sqflite/sqflite.dart';

Future<int>countDB(Database db, String tableName) async{
  final list = await db.rawQuery("select count(*) from $tableName");
  return Sqflite.firstIntValue(list);
}

Future<int> deleteAllDB(Database db, String tableName) async{
  return await db.rawDelete("delete from $tableName");
}

Future<int> deleteByIDDB(Database db, String tableName, int id) async{
  return await db.rawDelete("delete from $tableName where id = ?",[id]);
}

Future<bool>existsDB(Database db, String tableName, int id) async{
  final list = await db.rawQuery("select count(*) from $tableName where id = ?",[id]);
  final num = Sqflite.firstIntValue(list);
  return num > 0 ? true : false;
}