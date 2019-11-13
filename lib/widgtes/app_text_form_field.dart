import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {

  String label;
  String hint;
  BuildContext ctx; 
  bool obscureText; 
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType; 
  TextInputAction textInputAction;
  Brightness keyboardAppearance;
  FocusNode focusNode;
  FocusNode nextFocus;

  AppTextFormField(
    this.label, this.hint,
    {
     this.ctx, this.obscureText = false,
     this.controller, this.validator,
     this.keyboardType, this.keyboardAppearance = Brightness.light,
     this.textInputAction,this.focusNode, 
     this.nextFocus, 
    });

  @override
  Widget build(BuildContext ctx) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      keyboardAppearance: keyboardAppearance,
      focusNode: focusNode,
      onFieldSubmitted: (String text){
        if(nextFocus != null){
          FocusScope.of(ctx).requestFocus(nextFocus);
        }
      },
      // style: TextStyle(fontSize: 25, color: Colors.blue),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}