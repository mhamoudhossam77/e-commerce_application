 import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/model/categories-model.dart';
import 'package:ecommerce/model/home-model.dart';
import 'package:ecommerce/model/user-model.dart';
import 'package:ecommerce/shared/network/local/cache-helper/Cache_Helper.dart';
import 'package:ecommerce/shared/network/local/cache-keys/Cache_Keys.dart';
import 'package:ecommerce/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:ecommerce/shared/network/remote/endpoints/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit() : super(AppCubitInitial());

 
  static AppCubitCubit get(context) => BlocProvider.of(context);

   
  HomeModel? homeModel;
  category_model? categories;
  UserModel? userModel;

 
  void getHomeData() async {
    emit(GetHomeDataLoading());

    try {
       
      Response response = await DioHelper.getRequest(
        endpoint: HOME,
        token: CacheHelper.getStringFromCache("token"),
      );

      homeModel = HomeModel.fromJson(response.data);

      // Emit success or error based on the status
      if (homeModel?.status == true) {
        emit(GetHomeDataSucess());
      } else {
        emit(GetHomeDataError());
      }
    } catch (error) {
      emit(GetHomeDataError( ));
    }
  }


  
  void getCategoriesData() async {
    emit(GetcategoriesDataLoading());

    try {
       
      Response response = await DioHelper.getRequest(endpoint: CATEGORES);

      categories = category_model.fromJson(response.data);

     
      if (categories!.status == true) {
        emit(GetUserDataLSucess());
      } else {
        print(categories!.message);
        emit(GetcategoriesDataError());
      }
    } catch (error) {
      print(error);
      emit(GetcategoriesDataError());
    }
  }

   
  void getUserData() async {
    emit(GetUserDataLoading());

    try {
      
     
      Response response = await DioHelper.getRequest(
        endpoint: USER,
        token: CacheHelper.getStringFromCache("token"),
      );

      userModel = UserModel.fromJson(response.data);


      
      if (userModel?.status == true) {
        emit(GetUserDataLSucess());
      } else {
        emit(GetUserDataError());
      }
    } catch (error) {
      emit(GetUserDataError());
    }
  }


    void Logout() async {
    emit( LogoutLoading());

    try {
      print(TOKEN);
     
      Response response = await DioHelper.getRequest(
        endpoint: LOGOUT,
        token: CacheHelper.getStringFromCache("token"),
      );

      

 
      if (userModel?.status == true) {
        emit( Logoutsucess());
      } else {
        emit(LogoutError());
      }
    } catch (error) {
      emit(LogoutError());
    }
  }
}
