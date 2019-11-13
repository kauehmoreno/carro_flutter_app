import 'package:flutter/material.dart';

Future push(BuildContext ctx, Widget page){
  return Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext ctx) {
    return page;
  }));
}

// Future pop(BuildContext ctx, Widget page){
//   return Navigator.pop(ctx, )
// }