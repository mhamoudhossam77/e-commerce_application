 import 'package:dio/dio.dart';

abstract class DioHelper{
  static Dio? _dio;  

   static Future<void> initializeDio() async{   

    _dio ??= Dio(   
        BaseOptions(  
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
   })async{   
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
   })async{  
   _dio!.options.headers = {
    "Authorization": token,
   };
           return await _dio!.post(endpoint , queryParameters: queryParamters ,data: data);
  }


   static Future<Response>putRequest({
    required String endpoint , 
    String? token,
   Map<String,dynamic>? queryParamters,
   Map<String,dynamic>? data
   })async{  
   _dio!.options.headers = {
    "Authorization": token,
   };
           return await _dio!.put(endpoint , queryParameters: queryParamters ,data: data);
  }
}

