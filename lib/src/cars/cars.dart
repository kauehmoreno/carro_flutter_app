import 'dart:convert';

import 'package:http/http.dart' as http;

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
  var url = "http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$t";
  var response = await http.get(url);
  List listResponse = json.decode(response.body);
  final cars = listResponse.map<Car>((map)=> Car.fromJson(map)).toList();
  return cars;
}