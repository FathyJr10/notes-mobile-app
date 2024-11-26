// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextfieldFormAdd extends StatelessWidget {
  final String hintText;
  final TextEditingController myController;
  String? Function(String?)? validator;

  MyTextfieldFormAdd(
      {super.key,
      required this.hintText,
      required this.myController,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: myController,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
