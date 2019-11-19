
import 'dart:async';

import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/src/cars/db_context.dart';
import 'package:carro_flutter_app/src/db/db.dart';
import 'package:carro_flutter_app/utils/network.dart';

// CarBlock pattern
class CarBloc {

  final _streamCtrl = StreamController<List<Car>>();

  Stream<List<Car>> get stream => _streamCtrl.stream;

  Future<List<Car>>load(CarType type) async{
    try{
      final bool network = await isNetworkOn();
      if(!network){
          var database = await dB();
          List<Car> cars = await findCarByTypeDB(database, type);
          _streamCtrl.add(cars);
          return cars;
      }
      List<Car> cars = await getCars(type);
      try{
        _streamCtrl.add(cars);
        return cars;
      }catch(streamError, exception){
        print("fail to add on stream builder CarBloc: $streamError - exception: $exception");
        return null;
      }
    }catch(error){
      print("error to get cars: $error");
      _streamCtrl.addError(error);
      return null;
    }
  }

  void dispose(){
    _streamCtrl.close();
  }
}