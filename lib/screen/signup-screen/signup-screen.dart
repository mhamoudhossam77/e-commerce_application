import 'package:ecommerce/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/screen/login-screen/login-screen.dart';
import 'package:ecommerce/screen/mainlayout/Main-Layout.dart';
import 'package:ecommerce/shared/network/local/cache-helper/Cache_Helper.dart';
import 'package:ecommerce/widget/login-text-feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.grey,  
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              
              Text(
                "Sign up",
                style: GoogleFonts.acme(
                textStyle : TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,  
                ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              
               
              MyTextFormFeild(
                controller: _usernameController,
                title: "username",
                labelText: "Enter your username",  
                prefixIcon: const Icon(
                  Icons.person,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              
              MyTextFormFeild(
                controller: _emailController,
                title: "email",
                labelText: "Enter your email",
                prefixIcon: const Icon(
                  Icons.email_outlined,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

               
              MyTextFormFeild(
                controller: _passwordController,
                title: "password",
                labelText: "Enter your password",
                prefixIcon: const Icon(
                  Icons.lock_outline,
                ),
                isPassword: true,
              ),
              const SizedBox(
                height: 20.0,
              ),

               
              MyTextFormFeild(
                controller: _phoneController,
                title: "phone",
                labelText: "Enter your phone",
                prefixIcon: const Icon(
                  Icons.phone,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),

               
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state is SignupError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.message),
                      ),
                    );
                  }

                  if (state is SignupSucess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(state.model.message!),
                      ),
                    );
                    await CacheHelper.storeInCache(
                      "token", state.model.data!.token!,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => MainLayout()),
                    );
                  }
                },
                builder: (context, state) {
                  var cubit = AuthCubit.get(context);
                  if (state is SignupLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,  
                      minimumSize: const Size(double.infinity, 55.0),
                    ),
                    onPressed: () {
                      cubit.Signup(
                        Username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        phoneNumber: _phoneController.text,
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.acme(
                      textStyle : TextStyle(
                        color: Colors.black,  
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      ),  
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(), 
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.acme(
                      textStyle : TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 22.0,
                        ), 
                      ),
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