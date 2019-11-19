import 'package:carro_flutter_app/blocs/loripsum_bloc.dart';
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:flutter/material.dart';

class CarPageDetail extends StatelessWidget {
  final Car car;

  CarPageDetail(this.car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMap,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopupMenu(value),
            itemBuilder: (BuildContext ctx){
              return [
                PopupMenuItem(value:"edit", child: Text("Editar")),
                PopupMenuItem(value:"delete", child: Text("Deletar")),
                PopupMenuItem(value:"share", child: Text("Share")),
              ];
          })
        ],
      ),
      body: _body()
    );
  }
  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(car.image),
          _firstBlock(),
          Divider(),
          _secondBlock()
        ],
      )
    );
  }

  Row _firstBlock() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(car.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(car.type, style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red, size:40),
                  onPressed: _onClickFavorite,
                ),
                IconButton(
                  icon: Icon(Icons.share, size:40),
                  onPressed: _onClickShare,
                ),
              ],
            )
          ],
        );
  }

  Column _secondBlock(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(car.description, style: TextStyle(fontSize: 16)),
        SizedBox(height: 20),
        FutureBuilder(
          future: LoripsumBloc().fetch(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            return Text(snapshot.data, style: TextStyle(fontSize: 16));
          },
        )
      ],
    );
  }

  void _onClickVideo() {
  }

  void _onClickMap() {
  }

  void _onClickPopupMenu(String value) {
    switch (value) {
      case "edit":
        print("editar...");
        break;
      case "delete":
        print("deletar...");
        break;
      case "share":
        print("share...");
        break;
      default:
       print("not mapped...");
    }
  }

  void _onClickFavorite() {
  }

  void _onClickShare() {
  }
}