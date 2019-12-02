import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carro_flutter_app/src/api/response.dart';
import 'package:carro_flutter_app/src/cars/cars.dart';
import 'package:carro_flutter_app/utils/alert.dart';
import 'package:carro_flutter_app/utils/event_bus.dart';
import 'package:carro_flutter_app/utils/nav.dart';
import 'package:carro_flutter_app/widgtes/app_button.dart';
import 'package:carro_flutter_app/widgtes/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarFormPage extends StatefulWidget {
  final Car car;
  CarFormPage({this.car});

  @override
  _CarFormPageState createState() => _CarFormPageState();
}

class _CarFormPageState extends State<CarFormPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tName = TextEditingController();
  final tDesc = TextEditingController();
  final tType = TextEditingController();

  int _radioIndex = 0;

  var _showProgressBar = false;

  File _file;


  String _validateName(String v){
    if(v.isEmpty){
      return "Informe o nome do carro";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if(widget.car != null){
      tName.text = widget.car.name;
      tDesc.text = widget.car.description;
      tType.text = widget.car.type;
      _radioIndex = getIntByType(widget.car.type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.car != null ? widget.car.name : "Novo Carro",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          Text("Clique na image para tirar uma foto", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color:Colors.grey),),
          Divider(),
          Text("Tipo",style: TextStyle(color: Colors.blue,fontSize: 20,),),
          _radioType(),
          Divider(),
          AppTextFormField(
            "Nome",
            "",
            controller: tName,
            keyboardType: TextInputType.text,
            validator: _validateName,
          ),
          AppTextFormField(
            "Descrição",
            "",
            controller: tDesc,
            keyboardType: TextInputType.text,
            validator: _validateName,
          ),
          AppButton(
            "Salvar",
            onPressed: _onClickSalvar,
            showProgress: _showProgressBar,
          )
        ],
      ),
    );
  }

  _headerFoto() {
    return InkWell(
      onTap: _onclickFoto,
      child: _renderPhoto(),
    );
  }

  _radioType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickType,
        ),
        Text(
          "Clássicos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickType,
        ),
        Text(
          "Esportivos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickType,
        ),
        Text(
          "Luxo",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  _onClickSalvar()async {
    if(!_formKey.currentState.validate()){
      return;
    }
    var c = widget.car ?? Car();
    c.name = tName.text;
    c.description = tDesc.text;
    c.type = getTypeByIndex(_radioIndex);

    setState(() {
      _showProgressBar = true;
    });

    ResponseAPI<bool> response = await saveCar(c);

    if(response.ok){
      alert(context, "Carro salvo com sucesso", callback: (){
        EventBus.getEvent(context).sendEvent(CarEvent("car_save", c.type));
        pop(context);
      });
      return;
    }
    alert(context, response.errorMsg);

    setState(() {
      _showProgressBar = false;
    }); 
  }


  void _onClickType(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  void _onclickFoto() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null){
      setState(() {
        this._file = file;
      });
    }
  }

  _renderPhoto() {
    return _file != null 
    ? Image.file(_file, height: 150,): widget.car != null 
      ? CachedNetworkImage(imageUrl: widget.car.image, height: 150,)
      : Image.asset("assets/images/selfie.png", height: 150,);
  }
}

int getIntByType(String type) {
  switch (type) {
    case "classicos":
      return 0;
    case "esportivos":
      return 1;
    default:
      return 2;
  }
}

String getTypeByIndex(int index){
  switch (index) {
    case 0:
      return "classicos";
    case 1:
      return "esportivos";
    default:
      return "luxo";
  }
}
