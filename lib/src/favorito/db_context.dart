
import 'package:carro_flutter_app/src/favorito/favorito.dart';
import 'package:sqflite/sqflite.dart';

Future<int> saveFavorito(Database db, Favorito f) async{
  if(db == null){
    return 0;
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