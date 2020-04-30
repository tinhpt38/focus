
import 'package:flutter/material.dart';


class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final String hintText;
  final bool isObscure;
  final TextInputType inputType;
  
  AppTextField({this.controller, this.focus, this.hintText, this.isObscure, this.inputType});
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          fontFamily: 'Gotu'
      ),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(45)),
          borderSide: BorderSide(color: Colors.white)
        )
      ),
      controller: controller,
      focusNode: focus,
      obscureText: isObscure,
    );
  }
  
}
