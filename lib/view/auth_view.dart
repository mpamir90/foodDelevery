import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../services/auth_service.dart';

enum ViewState { login, register, otp, otpLogin }

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  ViewState viewState = ViewState.login;
  late String idVerify;
  TextEditingController cPhone = TextEditingController();
  TextEditingController cNama = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: headerLogin(),
          ),
          Flexible(
              flex: 2,
              child: StatefulBuilder(
                builder: (context, setState2) {
                  switch (viewState) {
                    case ViewState.login:
                      cPhone = TextEditingController();
                      cNama = TextEditingController();
                      return Container(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: ListView(
                          children: [
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            buildPhoneTextField(TextInputType.phone,
                                "Nomor Handphone", Icons.phone, cPhone),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state is OnOtpLoginError) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Error Terdeteksi"),
                                              content: Text(state.errorMessage),
                                            ));
                                  }
                                },
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      await AuthService()
                                          .auth
                                          .verifyPhoneNumber(
                                            phoneNumber:
                                                "+62" + cPhone.text.trim(),
                                            codeAutoRetrievalTimeout:
                                                (message) {},
                                            verificationCompleted:
                                                (phoneCredential) {},
                                            codeSent: (verificationId,
                                                forceResendingToken) {
                                              idVerify = verificationId;
                                              print("VerificationId: " +
                                                  idVerify);
                                            },
                                            verificationFailed: (error) {
                                              print("verificationFailed: " +
                                                  error.code);
                                            },
                                            timeout: Duration(minutes: 2),
                                          );
                                      viewState = ViewState.otpLogin;
                                      setState2(() {});
                                    },
                                    child: (state is OnOtpLoginLoading)
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text("Masuk"),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tidak punya akun? ",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                TextButton(
                                    onPressed: () {
                                      viewState = ViewState.register;
                                      setState2(() {});
                                    },
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18),
                                    ))
                              ],
                            )
                          ],
                        ),
                      );
                    case ViewState.register:
                      cPhone = TextEditingController();
                      return AnimatedContainer(
                        duration: Duration(seconds: 1),
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: ListView(
                          children: [
                            Text(
                              "Daftar",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            buildPhoneTextField(TextInputType.phone,
                                "Nomor Handphone", Icons.phone, cPhone),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await AuthService().auth.verifyPhoneNumber(
                                          phoneNumber:
                                              "+62" + cPhone.text.trim(),
                                          codeAutoRetrievalTimeout:
                                              (message) {},
                                          verificationCompleted:
                                              (phoneCredential) {},
                                          codeSent: (verificationId,
                                              forceResendingToken) {
                                            idVerify = verificationId;
                                            print(
                                                "VerificationId: " + idVerify);
                                          },
                                          verificationFailed: (error) {
                                            print("verificationFailed: " +
                                                error.code);
                                          },
                                          timeout: Duration(minutes: 2),
                                        );
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                  viewState = ViewState.otp;
                                  setState2(() {});
                                },
                                child: Text("Daftar"),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sudah Punya Akun? ",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                TextButton(
                                    onPressed: () {
                                      viewState = ViewState.login;
                                      setState2(() {});
                                    },
                                    child: Text(
                                      "Masuk",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18),
                                    ))
                              ],
                            )
                          ],
                        ),
                      );
                    case ViewState.otp:
                      cPhone = TextEditingController();
                      cNama = TextEditingController();
                      return AnimatedContainer(
                        duration: Duration(seconds: 1),
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: ListView(
                          children: [
                            Text(
                              "Masukan Kode OTP",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            buildTextField(
                                TextInputType.phone,
                                "Silahkan Cek Kotak Masuk Anda",
                                Icons.phone,
                                cPhone),
                            SizedBox(
                              height: 20,
                            ),
                            buildTextField(TextInputType.name,
                                "Masukan Nama Anda", Icons.person, cNama),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {},
                                builder: (context, state) => ElevatedButton(
                                  onPressed: () async {
                                    if (state is! OnOtpLoading) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          Otp(idVerify, cPhone.text.trim(),
                                              cNama.text));
                                    }
                                  },
                                  child: (state is OnOtpLoading)
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text("Verifikasi Nomor Handphone"),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      viewState = ViewState.register;
                                      setState(() {});
                                    },
                                    child: Text(
                                      "Kembali",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18),
                                    ))
                              ],
                            )
                          ],
                        ),
                      );
                    case ViewState.otpLogin:
                      return AnimatedContainer(
                        duration: Duration(seconds: 1),
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: ListView(
                          children: [
                            Text(
                              "Masukan Kode OTP",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            buildTextField(
                                TextInputType.phone,
                                "Silahkan Cek Kotak Masuk Anda",
                                Icons.phone,
                                cPhone),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {},
                                builder: (context, state) => ElevatedButton(
                                  onPressed: () async {
                                    if (state is! OnOtpLoading) {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(OtpLogin(idVerify, cPhone.text));
                                    }
                                  },
                                  child: (state is OnOtpLoading)
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text("Verifikasi Nomor Handphone"),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      viewState = ViewState.login;
                                      setState(() {});
                                    },
                                    child: Text(
                                      "Kembali",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18),
                                    ))
                              ],
                            )
                          ],
                        ),
                      );
                  }
                },
              )),
        ],
      ),
    );
  }

  Container buildTextField(TextInputType keyType, String hint,
      IconData iconData, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(
            iconData,
            color: Colors.black,
          ),
        ),
        keyboardType: keyType,
      ),
    );
  }

  Container buildPhoneTextField(TextInputType keyType, String hint,
      IconData iconData, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixText: "+62 ",
          prefixStyle: TextStyle(fontWeight: FontWeight.bold),
          prefixIcon: Icon(
            iconData,
            color: Colors.black,
          ),
        ),
        keyboardType: keyType,
      ),
    );
  }
}

Widget headerLogin() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(150))),
    child: Center(
        child: Icon(
      Icons.person,
      size: 100,
      color: Colors.white,
    )),
  );
}
