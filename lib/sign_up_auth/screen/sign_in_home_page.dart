import 'package:flutter/material.dart';

class SignInHomeScreen extends StatelessWidget {
  final String email;
  const SignInHomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Sign In Home Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Logged in successfully!!"),
              Text(email),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
