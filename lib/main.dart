import 'package:carro_flutter_app/blocs/favorite_bloc.dart';
import 'package:carro_flutter_app/pages/splash_page.dart';
import 'package:carro_flutter_app/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EventBus>(
          create:(BuildContext ctx) => EventBus(),
          dispose: (BuildContext ctx, EventBus event) => event.dispose(),
        ),
        Provider<FavoriteBloc>(
          create: (BuildContext ctx) => FavoriteBloc(),
          dispose: (BuildContext ctx, FavoriteBloc bloc) => bloc.dispose(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Color.fromARGB(255, 231, 231, 231)
        ),
        home: SplashPage(),
      ),
    );
  }
}