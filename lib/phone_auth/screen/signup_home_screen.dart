import 'package:flutter/material.dart';

import 'package:flutterweb/sign_up_auth/screen/sign_in_screen.dart';

class SignUpPhoneHomeScreen extends StatelessWidget {
  final int phone;
  const SignUpPhoneHomeScreen({super.key, required this.phone});

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
              Text("Created account successfully!! with phone: $phone"),
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
