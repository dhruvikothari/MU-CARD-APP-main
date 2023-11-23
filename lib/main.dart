import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mu_card/firebase_options.dart';
import 'package:mu_card/startscreen.dart';

void main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    title: 'CARD APP',
    theme: ThemeData(primarySwatch: Colors.cyan),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StartScreen();
  }

  static of(BuildContext context) {}
}
