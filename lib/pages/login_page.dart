import 'package:carro_flutter_app/utils/alert.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:carro_flutter_app/pages/home_page.dart';
import 'package:carro_flutter_app/src/api/response.dart';
import 'package:carro_flutter_app/src/login/login.dart';
import 'package:carro_flutter_app/widgtes/app_button.dart';
import 'package:carro_flutter_app/widgtes/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _ctrLogin = TextEditingController();

  final _ctrPassword = TextEditingController();

  final _focusPassword = FocusNode();

  @override 
  void initState(){
    super.initState();

    Future<User> future = cacheGetUser();
    // keep user logged
    future.then((User user){
      if(user != null){
        push(context, HomePage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext ctx){
    return Container(
      margin: EdgeInsets.only(top:170),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color:Color.fromARGB(255, 231, 231, 231),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0.0,15.0),blurRadius: 15.0),
          BoxShadow(color: Colors.black12, offset: Offset(0.0,-10.0),blurRadius: 10.0)
        ]
      ),
      child: Form(
        key: _formKey,
          child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              AppTextFormField(
                "Login", "Digite o login", 
                controller:_ctrLogin, validator: _validateLogin, ctx: ctx,
                keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next,
                nextFocus: _focusPassword,
              ),
              SizedBox(height: 20),
              AppTextFormField(
                "Senha", "Digite a senha", 
                obscureText: true, controller: _ctrPassword, ctx: ctx,
                validator: _validatePassword, keyboardType: TextInputType.number,
                focusNode: _focusPassword,
              ),
              SizedBox(height: 20),
              AppButton(
                "Login", 
                onPressed: () => _onClickLogin(ctx),
              ),
              Container(
                height: 46,
                margin: EdgeInsets.only(top:16),
                child: GoogleSignInButton(
                  onPressed: _onClickGoogleSignIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClickLogin(BuildContext ctx) async {
    if(!_formKey.currentState.validate()){
      return;
    }
    // its possible to set value on controller as well
    String login = _ctrLogin.text;
    String senha = _ctrPassword.text;

    ResponseAPI response =  await loginApi(login, senha);
  
    if(response.ok){
      // User user = response.result;
      // print(">>>> $user");
      push(ctx, HomePage(), replace: true);
      return;
    }
    alert(ctx, response.errorMsg);
  }

  String _validateLogin(String text){
    if(text.isEmpty){return "Login precisa ser preenchido";} return null;
  }

  String _validatePassword(String text){
    if(text.isEmpty){
      return "Senha precisa ser preenchida";
    }
    if(text.length < 3){
      return "Senha muito curta";
    }       
    return null;
  }

  void _onClickGoogleSignIn() {
    print("google sign");
  }
}