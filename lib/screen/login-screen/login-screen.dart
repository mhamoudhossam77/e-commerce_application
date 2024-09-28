import 'package:ecommerce/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/screen/mainlayout/Main-Layout.dart';
import 'package:ecommerce/screen/signup-screen/signup-screen.dart';
import 'package:ecommerce/shared/network/local/cache-helper/Cache_Helper.dart';
import 'package:ecommerce/widget/login-text-feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Login",
                style: GoogleFonts.acme(
                  textStyle: TextStyle(
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
                height: 50.0,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state is LoginError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          state.message,
                        ),
                      ),
                    );
                  }
                  if (state is LoginSucess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          state.model.message!,
                        ),
                      ),
                    );
                    await CacheHelper.storeInCache(
                        "token", state.model.data!.token!);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => MainLayout()));
                  }
                },
                builder: (context, state) {
                  var cubit = AuthCubit.get(context);
                  if (state is LoginLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      minimumSize: const Size(
                        double.infinity,
                        55.0,
                      ),
                    ),
                    onPressed: () {
                      cubit.Login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                    },
                    child: Text(
                      "Login",
                      style:GoogleFonts.acme(
                       textStyle : TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25.0,
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
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Signup",
                      style: GoogleFonts.acme(
                      textStyle:TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        fontSize: 23.0,
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
