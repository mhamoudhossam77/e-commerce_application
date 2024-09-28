 

import 'package:ecommerce/model/user-model.dart';
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


class  GetCategoryesElectronicDeviceLoading extends AppCubitState {}
class  GetCategoryElectronicDeviceSucess extends AppCubitState {}
class  GetCategoryElectronicDeviceError extends AppCubitState {}

class  GetCategoryFlightingCoronaLoading extends AppCubitState {}
class  GetCategoryFlightingCoronaSucess extends AppCubitState {}
class  GetCategoryFlightingCoronaError extends AppCubitState {}

class  GetCategorySportLoading extends AppCubitState {}
class  GetCategorySportSucess extends AppCubitState {}
class  GetCategorySportError extends AppCubitState {}

class  GetCategoryLightingtoolsLoading extends AppCubitState {}
class  GetCategoryLightingtoolsSucess extends AppCubitState {}
class  GetCategoryLightingtoolsError extends AppCubitState {}

class  GetCategoryClothesLoading extends AppCubitState {}
class  GetCategoryClothesSucess extends AppCubitState {}
class  GetCategoryClothesError extends AppCubitState {}

class  GetCategoryGroceriesLoading extends AppCubitState {}
class  GetCategoryGroceriesSucess extends AppCubitState {}
class  GetCategoryGroceriesError extends AppCubitState {}

 
class ChangeProductFavouriteSuccessfully extends AppCubitState{}
class ChangeProductFavouriteError extends AppCubitState{}

class ChangeProductCartSuccessfully extends AppCubitState{}
class ChangeProductCartError extends AppCubitState{}

class GetFavouritesLoading extends AppCubitState{}
class GetFavouritesSuccess extends AppCubitState{}
class GetFavouritesError extends AppCubitState{}


class GetCartLoading extends AppCubitState{}
class GetCartSucess extends AppCubitState{}
class GetCartError extends AppCubitState{}



class UpdateUserDataLoading extends AppCubitState{}

class UpdateUserDataSuccess extends AppCubitState{
  UpdateUserDataSuccess(UserModel? userModel);
}

class UpdateUserDataError extends AppCubitState{
  UpdateUserDataError(String string);
}