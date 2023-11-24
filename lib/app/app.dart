import 'package:flutter/material.dart';
import 'package:flutterweb/phone_auth/screen/signup_phone_screen.dart';

import 'package:flutterweb/sign_up_auth/screen/signup_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Sign In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpScreen(),
    );
  }
}
