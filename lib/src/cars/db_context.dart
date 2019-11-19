

import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:sqflite/sqflite.dart';

Future<int> saveCarDB(Database db, Car car) async{
  try{
    var id = db.insert(
      "car", car.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }catch(err){
    print("error on save car into db ${car.id} - ${car.name} - $err");
    return 0;
  }
}

Future<List<Car>> findAllCarDB(Database db) async{
  final list  = await db.rawQuery("select * from car");
  return list.map<Car>((json) => Car.fromJson(json)).toList();
}

Future<List<Car>> findCarByTypeDB(Database db, CarType type) async{
  final list = await db.rawQuery("select * from car where type=?",[type]);
  return list.map<Car>((json) => Car.fromJson(json)).toList();
}

Future<Car> findCarByIdDB(Database db, int id) async{
  final list = await db.rawQuery("select * from car where id = ?",[id]);
  if (list.length >0){
    return new Car.fromJson(list.first);
  }
  return null;
}

Future<bool> existCarDB(Database db, Car car) async{
  final result = await findCarByIdDB(db, car.id);
  return result != null ? true : false;
}

Future<int>countCarDB(Database db) async{
  final list = await db.rawQuery("selec count(*) from car");
  return Sqflite.firstIntValue(list);
}

Future<int>deleteCarDB(Database db,int id) async{
  return await db.rawDelete("dele from car where id = ?",[id]);
}

Future<int> deleteAllDB(Database db) async{
  return await db.rawDelete("delete from car");
}
