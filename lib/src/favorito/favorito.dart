
import 'package:carro_flutter_app/src/cars/cars.dart';

class Favorito{

  int id ;
  String nome;

  Favorito.fromCar(Car c){
    id = c.id;
    nome = c.name;
  }

  Favorito.fromJson(Map<String,dynamic>map){
    id = map["id"];
    nome = map["nome"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["nome"] = this.nome;
    return data;
  }
}