 

import 'package:flutter/foundation.dart';

@immutable
abstract class AppCubitState {}

class AppCubitInitial extends AppCubitState {}
class  GetHomeDataLoading extends AppCubitState {}
class  GetHomeDataSucess extends AppCubitState {}
class  GetHomeDataError extends AppCubitState {}

class  GetcategoriesDataLoading extends AppCubitState {}
class  GetcategoriesDataSucess extends AppCubitState {}
class  GetcategoriesDataError extends AppCubitState {}



class  GetUserDataLoading extends AppCubitState {}
class  GetUserDataLSucess extends AppCubitState {}
class  GetUserDataError extends AppCubitState {}

class  LogoutLoading extends AppCubitState {}
class  Logoutsucess extends AppCubitState {}
class  LogoutError extends AppCubitState {}