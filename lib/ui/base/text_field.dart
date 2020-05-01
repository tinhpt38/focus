
import 'package:flutter/material.dart';


class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final String hintText;
  final bool isObscure;
  final TextInputType inputType;
  final Function(String) validator;
  
  AppTextField({this.controller, this.focus, this.hintText, this.isObscure, this.inputType, this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: TextStyle(
          fontFamily: 'Gotu'
      ),
      decoration: InputDecoration(
        errorBorder:OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(45)),
        ),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(45)),
          borderSide: BorderSide(color: Colors.white, width: 1)
        )
      ),
      controller: controller,
      focusNode: focus,
      obscureText: isObscure,
    );
  }
  
}
