import 'dart:convert';

import 'package:carro_flutter_app/src/api/response.dart';
import 'package:carro_flutter_app/utils/preferences.dart';
import 'package:http/http.dart' as http;


class User{
  String login;
  String name;
  String email;
  String image;
  String token;
  List<String> roles;

  User.fromJson(Map<String,dynamic> map){
     this.name =  map["nome"];
     this.login = map["login"]; 
     this.email = map["email"]; 
     
     this.token = map["token"];
     this.roles = map["roles"] != null ? map["roles"].map<String>((role) => role.toString()).toList(): null;
  }

  @override
  String toString(){
    return "User { login: $login, name: $name, email: $email, token: $token, roles: $roles }";
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data["nome"] = this.name;
    data["login"] = this.login;
    data["email"] = this.email;
    data["urlFoto"] = this.image;
    data["token"] = this.token;
    data["roles"] = this.roles;
    return data;
  }
}

Future <ResponseAPI<User>> loginApi(String email, String password) async {
  // "http://livrowebservices.com.br/rest/login"
  const url = "http://carros-springboot.herokuapp.com/api/v2/login";

  Map params = {
    "username": email,
    "password": password,
  };

  Map<String,String> _headers = {
    "Conten-Type": "application/json"
  };

  String body = json.encode(params);
  try{
    User cachedUser = await cacheGetUser();
    if (cachedUser != null){
      return ResponseAPI.ok(cachedUser);
    }
    var resp = await http.post(url, body: body, headers: _headers);
    Map response = json.decode(resp.body);

    if (resp.statusCode != 200) {
      return ResponseAPI.error(response["error"]);
    }
    final user = User.fromJson(response);
    cacheUser(user);
    return ResponseAPI.ok(user);
  }catch(error) {
    print("error on login $error");
    return ResponseAPI.error("Não foi possível fazer o login");
  }
}

void cacheUser(User user) {
  String u = json.encode(user.toJson());
  prefSetString("user_cache", u);
}


Future<User> cacheGetUser() async {
  var u = await prefGetString("user_cache");
  if(u.isEmpty){
    return null;
  }
  Map map = json.decode(u);
  User user = User.fromJson(map);
  return user;
}

void clearUser(){
  prefSetString("user:cache", "");
}