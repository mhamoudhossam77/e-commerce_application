 import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/model/categories-model.dart';
import 'package:ecommerce/model/home-model.dart';
import 'package:ecommerce/model/user-model.dart';
import 'package:ecommerce/shared/network/local/cache-helper/Cache_Helper.dart';
import 'package:ecommerce/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:ecommerce/shared/network/remote/endpoints/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit() : super(AppCubitInitial());

  // Singleton instance getter
  static AppCubitCubit get(context) => BlocProvider.of(context);

  // Models
  HomeModel? homeModel;
  category_model? categories;
  UserModel? userModel;

  // Get Home Data
  void getHomeData() async {
    emit(GetHomeDataLoading());

    try {
      // Request data from the endpoint
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

  // Get Categories Data
  void getCategoriesData() async {
    emit(GetcategoriesDataLoading());

    try {
      // Request data from the endpoint
      Response response = await DioHelper.getRequest(endpoint: CATEGORES);

      categories = category_model.fromJson(response.data);

      // Emit success or error based on the status
      if (categories?.status == true) {
        emit(GetUserDataLSucess());
      } else {
        emit(GetcategoriesDataError());
      }
    } catch (error) {
      emit(GetcategoriesDataError());
    }
  }

  // Get User Data
  void getUserData() async {
    emit(GetUserDataLoading());

    try {
      // Request user data from the endpoint
      Response response = await DioHelper.getRequest(
        endpoint: USER,
        token: CacheHelper.getStringFromCache("token"),
      );

      userModel = UserModel.fromJson(response.data);

      // Emit success or error based on the status
      if (userModel?.status == true) {
        emit(GetUserDataLSucess());
      } else {
        emit(GetUserDataError());
      }
    } catch (error) {
      emit(GetUserDataError());
    }
  }
}
