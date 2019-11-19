import 'dart:async';

import 'package:carro_flutter_app/src/api/loripsum.dart';
import 'package:carro_flutter_app/utils/preferences.dart';

class LoripsumBloc{

  Future<String> fetch() async{
    var cached = await  _getFromCache();
    if (cached.isEmpty){
      String s = await getLoripsum();
      if (s.isEmpty){
        return "Não foi possível lodar o texto...";
      }
      _setOnCache(s);
    }
    return cached;
  }

  Future<String> _getFromCache() async {
    var u = await prefGetString("loripsun:data");
    if(u.isEmpty){
      return "";
    }
    return u;
  }

  void _setOnCache(String v) {
    prefSetString("loripsun:data", v);
  }
}