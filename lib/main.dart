import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/screen/login-screen/login-screen.dart';
import 'package:ecommerce/screen/mainlayout/Main-Layout.dart';
import 'package:ecommerce/shared/network/local/cache-helper/Cache_Helper.dart';
import 'package:ecommerce/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initializeCache();
  await DioHelper.initializeDio();
  String? token = CacheHelper.getStringFromCache("token");
  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppCubitCubit()..getHomeData()),
        BlocProvider(create: (_) => AuthCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: token == null ?const LoginScreen() : const MainLayout(),
      ),
    );
  }
}
