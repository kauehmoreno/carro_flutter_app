

import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/src/db/db_context.dart';
import 'package:sqflite/sqflite.dart';

Future<int> saveCarDB(Database db, Car car) async{
  if(db == null){
    return 0;
  }
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
  return countDB(db, "car");
}

Future<int>deleteCarDB(Database db,int id) async{
  return await deleteByIDDB(db, "car", id);
}

Future<int> deleteAllCarDB(Database db) async{
  return await deleteAllDB(db, "car");
}
