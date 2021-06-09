import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../services/auth_service.dart';
import 'home_view.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: StreamBuilder(
        stream: AuthService().auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print("User: " + snapshot.data.toString());
          if (snapshot.data != null) {
            return HomeView();
          }
          // return AuthView();
          return HomeView();
        },
      ),
    );
  }
}
