part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Otp extends AuthEvent {
  final String verificationId;
  final String smsCode;
  final String name;
  Otp(this.verificationId, this.smsCode, this.name);
}

class OtpLogin extends AuthEvent {
  final String id;
  final String smsCode;
  OtpLogin(this.id, this.smsCode);
}

class Logout extends AuthEvent {}
