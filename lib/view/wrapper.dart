import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/homeview_bloc.dart';
import 'auth_view.dart';
import 'view.dart';
import '../bloc/auth_bloc.dart';
import '../services/auth_service.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context)=>HomeviewBloc())
      ],
      child: StreamBuilder(
        stream: AuthService().auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print("User: " + snapshot.data.toString());
          if (snapshot.data != null) {
            return View();
          }
          return AuthView();
          // return HomeView();
        },
      ),
    );
  }
}
