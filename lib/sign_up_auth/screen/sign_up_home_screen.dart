import 'package:flutter/material.dart';

import 'package:flutterweb/sign_up_auth/screen/sign_in_screen.dart';

class SignUpHomeScreen extends StatelessWidget {
  final String email;
  const SignUpHomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text("Created account successfully!! with email ${email}"),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInScrn()));
                  },
                  child: const Text(
                    "Sign In",
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
