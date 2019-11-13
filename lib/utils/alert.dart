

import 'package:flutter/material.dart';

alert(BuildContext ctx, String msg){
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
                Navigator.pop(ctx);
              },
            )
          ],
        ),
      );
    }
  );
}