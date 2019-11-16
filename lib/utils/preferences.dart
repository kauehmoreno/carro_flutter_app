
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> prefGetBool(String key) async{
  var prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

void prefSetBool(String key, bool v) async{
  var prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, v);
}

Future<int> prefGetInt(String key) async{
  var prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key) ?? 0;
}

void prefSetInt(String key, int v) async{
  var prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, v);
}

Future<String> prefGetString(String key) async{
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? "";
}

void prefSetString(String key, String v) async{
  var prefs = await SharedPreferences.getInstance();
  prefs.setString(key, v);
}



