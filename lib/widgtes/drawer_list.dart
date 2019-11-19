
import 'package:carro_flutter_app/pages/login_page.dart';
import 'package:carro_flutter_app/src/login/login.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> future = cacheGetUser();
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
           FutureBuilder<User>(
             future: future,
             builder: (ctx, snapshot){
               User user = snapshot.data;
               return user != null ? _userHeader(user) : Container();
             }) ,
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

  UserAccountsDrawerHeader _userHeader(User user) {
    return UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.image),
            ),
          );
  }
}
onClickLogout(BuildContext context) {
  Navigator.pop(context);
  clearUser();
  push(context, LoginPage(), replace: true);
}