

import 'package:flutter/material.dart';
import 'package:medicineremainder/view/home.dart';
import 'package:medicineremainder/view/signin.dart';

void main() {
  runApp(MyApp());
  
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}