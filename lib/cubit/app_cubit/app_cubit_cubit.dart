import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/model/home-model.dart';
import 'package:ecommerce/shared/network/local/cache-helper/Cache_Helper.dart';
import 'package:ecommerce/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:ecommerce/shared/network/remote/endpoints/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';



class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit() : super(AppCubitInitial());
    static AppCubitCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;

  void getHomeData()async{

    emit(GetHomeDataLoading());

    Response response = await DioHelper.getRequest(endpoint:HOME ,
    token: CacheHelper.getStringFromCache("token")
    );
    

    homeModel = HomeModel.fromJson(response.data);

    if(homeModel!.status!){
      emit(GetHomeDataSucess());
    }else{
      emit(GetHomeDataError());
    }

  }
  
}
