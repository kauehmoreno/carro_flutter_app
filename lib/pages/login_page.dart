import 'package:carro_flutter_app/utils/alert.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:carro_flutter_app/pages/home_page.dart';
import 'package:carro_flutter_app/src/api/response.dart';
import 'package:carro_flutter_app/src/login/login.dart';
import 'package:carro_flutter_app/widgtes/app_button.dart';
import 'package:carro_flutter_app/widgtes/app_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // controls editing text from textForm field
  final _ctrLogin = TextEditingController();
  final _ctrPassword = TextEditingController();

  final _focusPassword = FocusNode();

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
    return Form(
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
          ],
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
      User user = response.result;
      print(">>>> $user");
      push(ctx, HomePage());
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
}