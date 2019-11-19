import 'package:http/http.dart' as http;

Future<String> getLoripsum() async {
  final String url = "https://loripsum.net/api";

  try{
  var resp = await http.get(url);

  if (resp.statusCode != 200){
    print("loripsun status code: ${resp.statusCode}");
    return "";
  }
  String text = resp.body;
  text = text.replaceAll("<p>", "").replaceAll("</p>", "");
  return text;
  }catch(err){
    print("loripsun error: $err");
    return "";
  }
}