 import 'package:flutter/material.dart';

class MyTextFormFeild extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final bool isPassword;

  const MyTextFormFeild({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.isPassword = false, required String title,
  }) : super(key: key);

  @override
  State<MyTextFormFeild> createState() => _MyTextFormFeildState();
}

class _MyTextFormFeildState extends State<MyTextFormFeild> {
  bool isObsecure = false;

  @override
  void initState() {
    super.initState();
    isObsecure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObsecure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),  
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.black, 
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
                icon: Icon(
                  isObsecure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
      ),
    );
  }
}
