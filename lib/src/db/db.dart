

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database _db;

Future<Database> dB() async {
  if(_db != null){
    return _db;
  }
  _db = await _initDB();
  return _db;
}

Future<Database> _initDB() async {
  try{
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "cars.db");
    print("path: $path");
    return await openDatabase(path, version:1, onCreate: _onCreate,onUpgrade: _onUpgrade);
  }catch(err){
    print("error to get path $err");
    return null;
  }
}
  
FutureOr<void> _onCreate(Database db, int version) async {
  await db.execute(
    'CREATE TABLE car(id INTEGER PRIMARY KEY, tipo TEXT, nome TEXT'
    ', descricao TEXT, urlFoto TEXT, urlVideo TEXT, latitude TEXT, longitude TEXT)'
  );
  await db.execute(
  'CREATE TABLE favorito(id INTEGER PRIMARY KEY, nome TEXT)');
}
  
FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async{
  print("_onUpgrade: oldversion: $oldVersion > newVersion: $newVersion");
  if(oldVersion ==  1 && newVersion == 2){
    print("old version $oldVersion vs new version $newVersion");
    // await db.execute("alter table car add column NOVA TEXT");
  }
}

Future<void> dbClose(Database db) async{
  db.close();
}
