

import 'package:carro_flutter_app/blocs/favorite_bloc.dart';
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/widgtes/car_list_view.dart';
import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {
  FavoriteList();
  
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> with AutomaticKeepAliveClientMixin<FavoriteList>{


   List<Car> cars;

  final _bloc = FavoriteBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState(){
    super.initState();
    _bloc.load();
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
            child: Text("Não foi possível buscar os carros favoritos", style: TextStyle(color: Colors.red, fontSize: 22)),
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
    return _bloc.load();
  }
}