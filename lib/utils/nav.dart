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

bool pop<T extends Object>(BuildContext ctx, [T result]){
  return Navigator.pop(ctx);
}