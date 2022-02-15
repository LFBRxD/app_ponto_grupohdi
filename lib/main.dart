import 'package:app_grupohdi/pages/LoginPage.dart';
import 'package:app_grupohdi/pages/PagesController.dart';
import 'package:app_grupohdi/pages/PontoPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      home: PontoPage(),
    );
  }


}
