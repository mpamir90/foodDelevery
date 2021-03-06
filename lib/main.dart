import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'view/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Hive.init(await path.getApplicationDocumentsDirectory().then((value) {
    print("Hive Path: "+value.path);
    return value.path;
  }));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.deepOrange[400],
      title: "Food Delevery",
      home: Wrapper(),
      theme: ThemeData(
          textTheme: TextTheme(
        headline3: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontStyle: FontStyle.italic),
        headline4: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        headline5: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        headline6: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
      )),
    );
  }
}
