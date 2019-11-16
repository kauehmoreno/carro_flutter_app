
import 'package:carro_flutter_app/pages/login_page.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foto = "https://miro.medium.com/fit/c/256/256/0*ZmGPgl9Ow9wFH7Aw.";
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Kauêh Moreno"),
              accountEmail: Text("kauehmoreno@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(foto),
              ),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                print("Item 1 ");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                print("Item 1 ");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => onClickLogout(context),
            ),
          ],
        )
      ),
    );
  }
}
onClickLogout(BuildContext context) {
  Navigator.pop(context);
  push(context, LoginPage(), replace: true);
}