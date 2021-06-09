part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//Otp
class OnOtpLoading extends AuthState {}

class OnOtpSucceded extends AuthState {}

class OnOtpError extends AuthState {
  final String errorMessage;
  OnOtpError(this.errorMessage);
}
//Otp

//Logout
class OnLogoutLoading extends AuthState {}

class OnLogoutSucceded extends AuthState {}

class OnLogoutError extends AuthState {
  final String errorMessage;
  OnLogoutError(this.errorMessage);
}
//Logout

//OtpLogin
class OnOtpLoginLoading extends AuthState {}

class OnOtpLoginError extends AuthState {
  final String errorMessage;
  OnOtpLoginError(this.errorMessage);
}
//OtpLogin
