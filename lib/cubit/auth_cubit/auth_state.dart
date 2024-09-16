part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}
class LoginSucess extends AuthState {
  final LoginResponsModel model;
  LoginSucess({required this.model});
}
class LoginError extends AuthState {
  final String message;

  LoginError({required this.message});
}
class SignupLoading extends AuthState {}
class SignupSucess extends AuthState {
  final SignupResponseModel model;

  SignupSucess({required this.model});
}
class SignupError extends AuthState {
  final String message ;

  SignupError({required this.message});
}