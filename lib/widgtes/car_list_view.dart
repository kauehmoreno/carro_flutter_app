import 'package:carro_flutter_app/pages/car_page_detail.dart';
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:flutter/material.dart';

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
                            onPressed: () => _onClickDetail(context, car),
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

  void _onClickDetail(BuildContext ctx, Car car) {
    push(ctx, CarPageDetail(car));
  }
}

