import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/signup_response_model.dart';
import 'package:ecommerce/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:ecommerce/shared/network/remote/endpoints/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context)=>BlocProvider.of(context);

  void Signup({ 
    required String Username,
    required String email ,
    required String password,
    required String phoneNumber
  })async{
   emit(SignupLoading());
   Response r = await DioHelper.postRequest(endpoint:REGISTER ,
   data: {
        "name" : Username ,
        "phone" : phoneNumber ,
        "email" :email ,
        "password" : password
     
   } );
   SignupResponseModel model = SignupResponseModel.fromJson(r.data);
   if(model.status!){
    emit(SignupSucess(model: model));
   }else{
    emit(SignupError(message: model.message!));
   }
  }
  
}
