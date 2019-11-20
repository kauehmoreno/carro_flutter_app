import 'package:carro_flutter_app/pages/car_form_page.dart';
import 'package:carro_flutter_app/pages/car_page.dart';
import 'package:carro_flutter_app/pages/favorito_page.dart';
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/utils/alert.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:carro_flutter_app/utils/preferences.dart';
import 'package:carro_flutter_app/widgtes/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState(){
    super.initState();
    _initTabs();
  }

  _initTabs() async {
    // this is only allowed based on single ticker provider already extended
    _tabController = TabController(length: 4, vsync: this);
    // retrieving from preference tha last tab bar index picked
    _tabController.index  = await prefGetInt("tabIndex");
    _tabController.addListener((){
      prefSetInt("tabIndex", _tabController.index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: "Clássicos", icon: Icon(Icons.directions_car)),
            Tab(text: "Esportivos",icon: Icon(Icons.directions_car)),
            Tab(text: "Luxo",icon: Icon(Icons.directions_car)),
            Tab(text: "Favorito",icon: Icon(Icons.favorite_border))
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CarPageList(CarType.classicos),
          CarPageList(CarType.esportivos),
          CarPageList(CarType.luxo),
          FavoriteList(),
        ]
      ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAddCar,
      ),
      ),
    );
  }    

  void _onClickAddCar() {
    push(context, CarFormPage());
  }
}