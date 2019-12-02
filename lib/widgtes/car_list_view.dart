import 'package:cached_network_image/cached_network_image.dart';
import 'package:carro_flutter_app/pages/car_page_detail.dart';
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarListView extends StatelessWidget {
  final List<Car> cars;

  CarListView(this.cars);

  @override
  Widget build(BuildContext context) {  
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: cars != null ? cars.length: 0,
          itemBuilder: (BuildContext ctx, int index){
            Car car = cars[index];
            return InkWell(
              onTap: () => _onClickDetail(context, car),
              onLongPress: () => _onLongPress(context,car),
              child: Card(
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
                      child: CachedNetworkImage(
                        imageUrl: car.image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0_AwAlrkiziiz6_mkuavRL-TDJpoFpo9hrIeHDZu4BMY0K5M&s",
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      // CachedImage.network(car.image??"", width: 250)
                    )
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
                            onPressed: () => _onClickDetail(context, car),
                          ),
                          FlatButton(
                            child: const Text("SHARE"),
                            onPressed: ()=> _onClickShare(context, car),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          ),
            );
        },
      ),
    ),
  );}

  void _onClickDetail(BuildContext ctx, Car car) {
    push(ctx, CarPageDetail(car));
  }

  void _onLongPress(BuildContext ctx, Car car) {
    showBottomSheet(context: ctx, builder: (BuildContext ctx){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              car.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text("Detalhes"),
            leading: Icon(Icons.directions_car),
            onTap: (){
              pop(ctx);
              _onClickDetail(ctx, car);
            },
          ),
          ListTile(
            title: Text("Share"),
            leading: Icon(Icons.share),
            onTap: (){
              pop(ctx);
              _onClickShare(ctx, car);
            },
          )
        ],
      );
    });
  }

  void _onClickShare(BuildContext ctx, Car car) {
    print("sharing car ${car.name}");
    Share.share(car.image, subject: "Olhe esse ${car.name} do tipo ${car.type}");
  }
}

