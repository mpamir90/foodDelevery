import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_service.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get user => auth.currentUser;

  Future<void> otp(
    String verificationId,
    String smsCode,
    String name,
  ) async {
    await auth
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode))
        .then((value) async {
      await value.user!.updateDisplayName(name);
      await FirestoreService().createUser(name, user!.phoneNumber.toString(),value.user!.uid);
    });
  }

  Future<void> otpLogin(String id, String smsCode) async {
    await auth
        .signInWithCredential(
            PhoneAuthProvider.credential(verificationId: id, smsCode: smsCode))
        .then((value) async {
      if (value.user != null) {
        if (value.user!.displayName == null) {
          await logOut();
        }
      }
    });
  }

  Future<void> logOut() async {
    await auth.signOut();
  }
}
