import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/widgtes/car_list_view.dart';
import 'package:carro_flutter_app/widgtes/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(tabs: <Widget>[
          Tab(text: "Clássicos"),
          Tab(text: "Esportivos"),
          Tab(text: "Luxo"),
        ]),
      ),
      body: TabBarView(children: <Widget>[
        CarListView(CarType.classicos),
        CarListView(CarType.esportivos),
        CarListView(CarType.luxo)
      ]),
      drawer: DrawerList(),
      ),
    );
  }    
}