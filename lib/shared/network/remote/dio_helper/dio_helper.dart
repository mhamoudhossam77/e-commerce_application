 import 'package:dio/dio.dart';

abstract class DioHelper{
  static Dio? _dio;  // object of dio

   static Future<void> initializeDio() async{   // function for initialize Dio

    _dio ??= Dio(   
        BaseOptions( // control the baseurl
          baseUrl: "https://student.valuxapps.com/api/",
          receiveDataWhenStatusError: true,
          validateStatus: (status) => status! <= 500,
          headers: {
            'lang' : 'en'
          }
          
        )
        
      );

       

  }

 static Future<Response>getRequest({
    required String endpoint , 
    String? token,
   Map<String,dynamic>? queryParamters
   })async{  // function the type is a Future
   _dio!.options.headers = {
    "Authorization": token,
   };
           return await _dio!.get(endpoint , queryParameters: queryParamters);
  }

   static Future<Response>postRequest({
    required String endpoint , 
    String? token,
   Map<String,dynamic>? queryParamters,
   Map<String,dynamic>? data
   })async{  // function the type is a Future
   _dio!.options.headers = {
    "Authorization": token,
   };
           return await _dio!.post(endpoint , queryParameters: queryParamters ,data: data);
  }
}

