
import 'dart:async';

import 'package:carro_flutter_app/src/cars/cars.dart';

// CarBlock pattern
class CarBloc {

  final _streamCtrl = StreamController<List<Car>>();

  Stream<List<Car>> get stream => _streamCtrl.stream;

  load(CarType type) async{
    List<Car> cars = await getCars(type);

    _streamCtrl.add(cars);
  }

  void dispose(){
    _streamCtrl.close();
  }
}