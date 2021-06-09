import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    //OTP
    if (event is Otp) {
      yield OnOtpLoading();

      try {
        await AuthService()
            .otp(event.verificationId, event.smsCode, event.name);
        print("User: " + AuthService().user.toString());
        yield OnOtpSucceded();
      } catch (e) {
        yield OnOtpError(e.toString());
      }
    }

    //OtpLogin
    if (event is OtpLogin) {
      yield OnOtpLoginLoading();

      try {
        await AuthService().otpLogin(event.id, event.smsCode);
      } catch (e) {
        yield OnOtpLoginError(e.toString());
      }
    }

    //Logout
    if (event is Logout) {
      yield OnLogoutLoading();

      try {
        await AuthService().logOut();
      } catch (e) {
        yield OnLogoutError(e.toString());
      }
    }
  }
}
