 

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


class  GetCategoriesDetailesLoading extends AppCubitState {}
class  GetCategoriesDetailesSucess extends AppCubitState {}
class  GetCategoriesDetailesError extends AppCubitState {}

class ChangeProductFavouriteSuccessfully extends AppCubitState{}
class ChangeProductFavouriteError extends AppCubitState{}

class GetFavouritesLoading extends AppCubitState{}
class GetFavouritesSuccess extends AppCubitState{}
class GetFavouritesError extends AppCubitState{}