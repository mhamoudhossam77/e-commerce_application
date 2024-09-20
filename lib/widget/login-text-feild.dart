import 'package:flutter/material.dart';
 

class MyTextFormFeild extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String labelText;
  final Icon prefixIcon;
  final bool isPassword;

  const MyTextFormFeild({
    Key? key,
    required this.controller,
    required this.title,
    required this.labelText,
    required this.prefixIcon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<MyTextFormFeild> createState() => _MyTextFormFeild();
}

class _MyTextFormFeild extends State<MyTextFormFeild> {
  bool isObsecure = false;
  @override
  void initState() {
    super.initState();
    isObsecure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style:  
             const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
         
        ),
        const SizedBox(
          height: 15.0,
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: isObsecure,
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              labelText: widget.labelText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        SetState() {
                          isObsecure = !isObsecure;
                        }
                      },
                      icon: Icon(
                        isObsecure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_off_outlined,
                      ))
                  : null),
        ),
      ],
    );
  }
}
