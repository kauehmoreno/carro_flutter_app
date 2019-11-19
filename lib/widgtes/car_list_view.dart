import 'dart:async';

import 'package:carro_flutter_app/blocs/page_bloc.dart';
import 'package:carro_flutter_app/pages/car_page.dart';
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:flutter/material.dart';

class CarListView extends StatefulWidget {
  final CarType carType;
  CarListView(this.carType);

  @override
  _CarListViewState createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> with AutomaticKeepAliveClientMixin<CarListView>{
  List<Car> cars;

  final _bloc = CarBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState(){
    super.initState();
    _bloc.load(widget.carType);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (BuildContext ctx, AsyncSnapshot snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text("Não foi possível buscar os carros", style: TextStyle(color: Colors.red, fontSize: 22)),
          );
        }
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        List<Car> cars = snapshot.data;
        return _listCars(cars);
      },
    );
  }

  Center _listCars(List<Car> cars) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: cars != null ? cars.length: 0,
          itemBuilder: (BuildContext ctx, int index){
            Car car = cars[index];
            return Card(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: AnimatedContainer(
                      duration: Duration(seconds: 500),
                      curve: Curves.easeIn,
                      child: Image.network(car.image??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0_AwAlrkiziiz6_mkuavRL-TDJpoFpo9hrIeHDZu4BMY0K5M&s", width: 250))
                    ),
                    Text(
                      car.name ?? "Sem nome", 
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 22)
                    ),
                    Text(
                      "descrição...", 
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 16)
                    ),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text("DETALHES"),
                            onPressed: () => _onClickDetail(car),
                          ),
                          FlatButton(
                            child: const Text("SHARE"),
                            onPressed: (){},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          );
        },
      ),
    ),
  );}

  void _onClickDetail(Car car) {
    push(context, CarPage(car));
  }
}

