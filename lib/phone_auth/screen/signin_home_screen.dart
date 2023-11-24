import 'package:flutter/material.dart';

class SignInPhoneHomeScreen extends StatelessWidget {
  const SignInPhoneHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Phone Home Screen",
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("Login Successfull...")],
          ),
        ),
      ),
    );
  }
}
