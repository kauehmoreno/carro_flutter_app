import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/utils/preferences.dart';
import 'package:carro_flutter_app/widgtes/car_list_view.dart';
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
    _tabController = TabController(length: 3, vsync: this);
    // retrieving from preference tha last tab bar index picked
    _tabController.index  = await prefGetInt("tabIndex");
    _tabController.addListener((){
      prefSetInt("tabIndex", _tabController.index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: "Clássicos"),
            Tab(text: "Esportivos"),
            Tab(text: "Luxo"),
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CarListView(CarType.classicos),
          CarListView(CarType.esportivos),
          CarListView(CarType.luxo)
        ]
      ),
      drawer: DrawerList(),
      ),
    );
  }    
}