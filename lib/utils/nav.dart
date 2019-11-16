import 'package:flutter/material.dart';

Future push(BuildContext ctx, Widget page, {bool replace = false}){
  if(replace){
    return Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (BuildContext ctx) {
      return page;
    }));
  }
  return Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext ctx) {
      return page;
    }));
}

// Future pop(BuildContext ctx, Widget page){
//   return Navigator.pop(ctx, )
// }