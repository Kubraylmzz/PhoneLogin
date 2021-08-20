import 'package:flutter/material.dart';
import 'package:phone_verification_flutter/HomePage.dart';
import 'package:phone_verification_flutter/PhoneVerification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: PhoneVerification(),
    );
  }
}
