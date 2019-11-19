import 'package:carro_flutter_app/pages/home_page.dart';
import 'package:carro_flutter_app/pages/login_page.dart';
import 'package:carro_flutter_app/src/login/login.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState(){
    super.initState();
    Future delay = Future.delayed(Duration(seconds: 2));

    Future<User> future = cacheGetUser();

    Future.wait([delay, future]).then((List values){
      User user = values[1];
      if(user != null){
        push(context, HomePage(), replace: true);
        return;
      }
      push(context, LoginPage(), replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(child: CircularProgressIndicator(),),
    );
  }
}