import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:flutter/material.dart';

class CarPage extends StatelessWidget {
  final Car car;

  CarPage(this.car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: _body()
    );
  }
  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.network(car.image)
    );
  }
}