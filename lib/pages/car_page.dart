

import 'dart:async';

import 'package:carro_flutter_app/blocs/page_bloc.dart';
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/utils/event_bus.dart';
import 'package:carro_flutter_app/widgtes/car_list_view.dart';
import 'package:flutter/material.dart';

class CarPageList extends StatefulWidget {
  final CarType carType;
  CarPageList(this.carType);
  
  @override
  _CarPageListState createState() => _CarPageListState();
}

class _CarPageListState extends State<CarPageList> with AutomaticKeepAliveClientMixin<CarPageList>{


   List<Car> cars;

  final _bloc = CarBloc();

  StreamSubscription<Event> subscription;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState(){
    super.initState();
    _bloc.load(widget.carType);

    // escutando um evento de stream
    final bus = EventBus.getEvent(context);
    subscription = bus.stream.listen((Event ev){
      CarEvent carEvt = ev;
      if(carEvt.identifier == widget.carType.toString()){
        _bloc.load(widget.carType);
      }
    });
    
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    subscription.cancel();
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
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarListView(cars)
        );
      },
    );
  }
  Future<void> _onRefresh() {
    return _bloc.load(widget.carType);
  }
}