import 'dart:convert';

import 'package:carro_flutter_app/src/api/response.dart';
import 'package:http/http.dart' as http;


class User{
  String login;
  String name;
  String email;
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
    var resp = await http.post(url, body: body, headers: _headers);
    Map response = json.decode(resp.body);

    if (resp.statusCode != 200) {
      return ResponseAPI.error(response["error"]);
    }
    final user = User.fromJson(response);
    return ResponseAPI.ok(user);
  }catch(error) {
    print("error on login $error");
    return ResponseAPI.error("Não foi possível fazer o login");
  }
}