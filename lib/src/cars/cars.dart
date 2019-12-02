import 'dart:convert';

import 'package:carro_flutter_app/src/api/response.dart';
import 'package:carro_flutter_app/src/cars/db_context.dart';
import 'package:carro_flutter_app/src/db/db.dart';
import 'package:carro_flutter_app/src/login/login.dart';
import 'package:carro_flutter_app/utils/event_bus.dart';
import 'package:http/http.dart' as http;


class CarEvent extends Event {
  String action;
  String identifier;
  CarEvent(this.action, this.identifier);
}


class Car{
  int id;
  String name;
  String type;
  String description;
  String image;
  String video;
  String lat;
  String long;


  Car({
    this.id, this.name, this.type,
    this.description,this.image, this.video,
    this.lat,this.long
  });

  Car.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['nome'];
    type = json['tipo'];
    description = json['descricao'];
    image = json['urlFoto'];
    video = json['urlVideo'];
    lat = json['latitude'];
    long = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id ;
    data['nome'] = this.name ;
    data['tipo'] = this.type ;
    data['descricao'] = this.description ;
    data['urlFoto'] = this.image ;
    data['urlVideo'] = this.video ;
    data['latitude'] = this.lat ;
    data['longitude'] = this.long ;
    return data;
  }
}

enum CarType{
  classicos,
  esportivos,
  luxo
}

Future<List<Car>> getCars(CarType type) async {
  // gambe
  var t = type.toString().replaceAll("CarType.", "");

  User user = await cacheGetUser();

  Map<String, String> header = {
    "Content-type": "application/json",
    "Authorization": "Bearer ${user.token ?? null}"
  };
  var url = "http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$t";
  var response = await http.get(url, headers: header);
  if(response.statusCode != 200){
    Map<String,dynamic> resp = json.decode(response.body);
    throw new Exception(resp["error"]?? "fail to fetch");
  }
  List listResponse = json.decode(response.body);
  final cars = listResponse.map<Car>((map)=> Car.fromJson(map)).toList();
  final database = await dB();
  cars.forEach((Car car) => saveCarDB(database, car));
  return cars;
}

Future<ResponseAPI<bool>> saveCar(Car car) async {
  User user = await cacheGetUser();

  Map<String, String> header = {
    "Content-type": "application/json",
    "Authorization": "Bearer ${user.token ?? null}"
  };

  var url = "http://carros-springboot.herokuapp.com/api/v2/carros";
  
  if(car.id != null){
    url += "/${car.id}";
  }
  
  var resp = await (car.id == null 
  ? http.post(url,body: json.encode(car.toJson()), headers: header)
  : http.put(url,body: json.encode(car.toJson()), headers: header));

  if(resp.statusCode == 200 || resp.statusCode == 201){
    // Map mapResp = json.decode(resp.body);
    // Car newCar = Car.fromJson(mapResp);
    return ResponseAPI.ok(true);
  }
  if(resp.statusCode == 401 || resp.statusCode == 403){
    return ResponseAPI.error("Ação não autorizada!");
  }
  return ResponseAPI.error("Não foi possível salvar o carro");
}