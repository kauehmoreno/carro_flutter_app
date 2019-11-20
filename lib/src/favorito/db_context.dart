
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/src/db/db_context.dart';
import 'package:carro_flutter_app/src/favorito/favorito.dart';
import 'package:sqflite/sqflite.dart';

Future<int> saveFavorito(Database db, Favorito f) async{
  if(db == null){
    return 0;
  }

  bool exist = await existsDB(db, "favorito", f.id);
  if (exist){
    return await deleteByIDDB(db, "favorito", f.id);
  }

  try{
    return db.insert(
      "favorito", f.toJson(), 
      conflictAlgorithm: ConflictAlgorithm.replace);
  }catch(err){
    print("fail to save favorito ${f.id} - ${f.nome} - $err");
    return 0;
  }
}

Future<List<Car>> getAllFavoritesCars(Database db) async{
  final list = await db.rawQuery("select * from car c, favorito f where c.id = f.id ");
  return list.map<Car>((json) => Car.fromJson(json)).toList();
}

Future<bool> isFavorite(Database db, int id) async{
  return await existsDB(db, "favorito", id);
}