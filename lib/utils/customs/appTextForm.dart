import 'package:flutter/material.dart';

class AppTextForm extends StatelessWidget {
  AppTextForm(
      {this.cont,
      this.onFieldSubmit,
      this.s,
      this.obscure = false,
      this.warning = '',
      this.validator});

  TextEditingController cont = TextEditingController();
  bool obscure;
  final Function onFieldSubmit;
  String s, warning;
  final Function validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmit,
      validator: validator,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      controller: cont,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: s,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.blueGrey.shade500,
        labelStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.only(left: 30),
        helperText: warning,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade500),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade500),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
