import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:relative_scale/relative_scale.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (BuildContext context, double height, double width,
              double Function(double) sy, double Function(double) sx) =>
          Scaffold(
              body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SafeArea(
                child: ListTile(
              title: CircleAvatar(
                backgroundImage: AssetImage("assets/makanan.jpg"),
                radius: sx(100),
              ),
              subtitle: Text(
                AuthService().user!.displayName.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            )),
            GestureDetector(
              onTap: () async {
                await AuthService().logOut();
              },
                          child: Card(
                child: ListTile(leading: Icon(Icons.logout),title: Text("Logout"),),
              ),
            )
          ],
        ),
      )),
    );
  }
}
