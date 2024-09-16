import 'package:ecommerce/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/widget/signup-text-feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Create your account",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20.0,
              ),
              MyTextformfield(
                hintText: "Username",
                prefixIcon: Icon(Icons.person),
                controller: _usernameController,
              ),
              SizedBox(
                height: 25.0,
              ),
              MyTextformfield(
                hintText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
                controller: _emailController,
              ),
              SizedBox(
                height: 25.0,
              ),
              MyTextformfield(
                hintText: "password",
                prefixIcon: Icon(Icons.lock),
                controller: _passwordController,
                isPassword: true,
              ),
              SizedBox(
                height: 25.0,
              ),
              MyTextformfield(
                hintText: " phone",
                prefixIcon: Icon(Icons.phone),
                controller: _phoneController,
              ),
              SizedBox(
                height: 25.0,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is SignupError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.message)));
                  }

                  if (state is SignupSucess) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(state.model.message!),
                    ));
                  }
                },
                builder: (context, state) {
                  var cubit = AuthCubit.get(context);
                  if (state is SignupLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      cubit.Signup(
                          Username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          phoneNumber: _phoneController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 120.0)),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
