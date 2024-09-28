import 'package:flutter/material.dart';

class MyTextFormFeild extends StatelessWidget {
  final String title;
  final String labelText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final bool isPassword;

  const MyTextFormFeild({
    super.key,
    required this.title,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}