import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/screens/dashboard.dart';
import 'package:untitled3/test.dart';

import 'login/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
 //home: TestPage(),
   home: LoginPage(),
    );
  }
}
