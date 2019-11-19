
class Favorito{

  int id ;
  String nome;

  Favorito.fromJson(Map<String,dynamic>map){
    id = map["id"];
    nome = map["nome"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["nome"] = this.nome;
    return data;
  }
}