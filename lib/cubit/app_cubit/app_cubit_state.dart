 

import 'package:flutter/foundation.dart';

@immutable
abstract class AppCubitState {}

class AppCubitInitial extends AppCubitState {}
class  GetHomeDataLoading extends AppCubitState {}
class  GetHomeDataSucess extends AppCubitState {}
class  GetHomeDataError extends AppCubitState {}
class  searchproductsLoading extends AppCubitState {}
class  searchproductsSucess extends AppCubitState {}
class  searchproductsError extends AppCubitState {}