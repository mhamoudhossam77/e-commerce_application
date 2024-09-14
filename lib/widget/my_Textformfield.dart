import 'package:flutter/material.dart';

class MyTextformfield extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final bool isPassword;

  const MyTextformfield(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      required this.controller,
      this.isPassword = false});

  @override
  State<MyTextformfield> createState() => _MyTextformfield();
}

class _MyTextformfield extends State<MyTextformfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 20.0),
          prefixIcon: widget.prefixIcon),
    );
  }
}
