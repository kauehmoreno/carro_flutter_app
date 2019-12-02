import 'package:cached_network_image/cached_network_image.dart';
import 'package:carro_flutter_app/blocs/loripsum_bloc.dart';
import 'package:carro_flutter_app/pages/car_form_page.dart';
import 'package:carro_flutter_app/pages/video_page.dart';
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/src/db/db.dart';
import 'package:carro_flutter_app/src/favorito/db_context.dart';
import 'package:carro_flutter_app/src/favorito/favorito.dart';
import 'package:carro_flutter_app/utils/alert.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';

class CarPageDetail extends StatefulWidget {
  final Car car;

  CarPageDetail(this.car);

  @override
  _CarPageDetailState createState() => _CarPageDetailState();
}

class _CarPageDetailState extends State<CarPageDetail> {
  Color _color = Colors.grey;

  @override
  void initState() {
    super.initState();
    final futureDb = dB();
    futureDb.then((db){
      Future<bool> futurebool = isFavorite(db, widget.car.id);
      futurebool.then((bool isFavorite){
        setState(() {
          _color = isFavorite ? Colors.red : Colors.grey;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMap,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed:()=> _onClickVideo(context, widget.car),
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
          CachedNetworkImage(
            imageUrl: widget.car.image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0_AwAlrkiziiz6_mkuavRL-TDJpoFpo9hrIeHDZu4BMY0K5M&s",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          _firstBlock(widget.car),
          Divider(),
          _secondBlock()
        ],
      )
    );
  }

  Row _firstBlock(Car car) {
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
                  icon: Icon(Icons.favorite, color: _color, size:40),
                  onPressed: () => _onClickFavorite(car),
                ),
                IconButton(
                  icon: Icon(Icons.share, size:40),
                  onPressed: () => _onClickShare(car),
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
        Text(widget.car.description, style: TextStyle(fontSize: 16)),
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

  void _onClickVideo(BuildContext context,Car car) {
    if(car.video != null && car.video.isNotEmpty){
      push(context, VideoPage(car));
      return;
    }
    alert(context, "Este carro não possuí vídeo");
  }

  void _onClickMap() {
  }

  void _onClickPopupMenu(String value) {
    switch (value) {
      case "edit":
        push(context, CarFormPage(car: widget.car));
        print("editar...");
        break;
      case "delete":
        print("deletar...");
        break;
      case "share":
        _onClickShare(widget.car);
        break;
      default:
       print("not mapped...");
    }
  }

  void _onClickFavorite(Car c) {
    final f = Favorito.fromCar(c);
    Future<Database> futureDb = dB();
    futureDb.then((Database db){
      Future<int> futureSave = saveFavorito(db, f);
      futureSave.then((int result){
        var feedback = result > 0 ? "succeed": "fail";
        print("favorito save has $feedback");
        setState(() {
          _color = result > 0 ? _color == Colors.red ? Colors.grey : Colors.red : Colors.grey;
        });
      });
    });
  }

  void _onClickShare(Car car) {
    Share.share(car.image, subject: "Olhe esse ${car.name} do tipo ${car.type}");
  }
}