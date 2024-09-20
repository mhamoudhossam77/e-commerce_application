part of 'app_cubit_cubit.dart';

@immutable
abstract class AppCubitState {}

class AppCubitInitial extends AppCubitState {}
class  GetHomeDataLoading extends AppCubitState {}
class  GetHomeDataSucess extends AppCubitState {}
class  GetHomeDataError extends AppCubitState {

  
}