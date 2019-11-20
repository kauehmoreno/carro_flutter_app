

import 'package:carro_flutter_app/utils/nav.dart';
import 'package:flutter/material.dart';

alert(BuildContext ctx, String msg, {Function callback}){
  showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (ctx) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: (){
                pop(ctx);
                if(callback != null){
                  callback();
                }
              },
            )
          ],
        ),
      );
    }
  );
}