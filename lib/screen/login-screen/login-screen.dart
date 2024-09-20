import 'package:ecommerce/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/screen/mainlayout/Main-Layout.dart';
import 'package:ecommerce/screen/signup-screen/signup-screen.dart';
import 'package:ecommerce/shared/network/local/cache-helper/Cache_Helper.dart';
import 'package:ecommerce/widget/login-text-feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 

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
      backgroundColor: Colors.green,
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
                "Login",
                style:  
                    TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
             
              SizedBox(
                height: 20.0,
              ),
              MyTextFormFeild(
                controller: _emailController,
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
                controller: _passwordController,
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
                      backgroundColor: Colors.white,
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
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Signup",
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
