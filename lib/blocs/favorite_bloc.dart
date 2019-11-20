
import 'dart:async';

import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/src/db/db.dart';
import 'package:carro_flutter_app/src/favorito/db_context.dart';

// FavoriteBloc pattern
class FavoriteBloc {

  final _streamCtrl = StreamController<List<Car>>();

  Stream<List<Car>> get stream => _streamCtrl.stream;

  Future<List<Car>>load() async{
    try{
      var database = await dB();
      List<Car> cars = await getAllFavoritesCars(database);
      _streamCtrl.add(cars);
      return cars;
    }catch(error){
      print("error to get favorite cars: $error");
      _streamCtrl.addError(error);
      return null;
    }
  }
  void dispose(){
    _streamCtrl.close();
  }
}