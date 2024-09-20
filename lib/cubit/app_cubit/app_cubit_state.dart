 

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