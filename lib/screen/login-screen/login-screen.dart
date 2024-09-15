import 'package:ecommerceaapp/Widget/My_Text_Form_Feild.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Text(
                "LOGIN",
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Login to buy our special products",
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MyTextFormFeild(
                title: "E-mail",
                labelText: "E-mail",
                prefixIcon: const Icon(
                  Icons.email_outlined,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MyTextFormFeild(
                title: "Password",
                labelText: "Password",
                prefixIcon: const Icon(
                  Icons.lock_outline,
                ),
                isPassword: true,
              ),
              const SizedBox(
                height: 50.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //   context,
                      // //  MaterialPageRoute(
                      //    // builder: (_) => const RegisterScreen(),
                      //   ),
                     //);
                    },
                    child: const Text(
                      "Register",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}