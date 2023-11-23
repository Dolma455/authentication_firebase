import 'package:flutter/material.dart';
import 'package:flutterweb/signin_auth/user_auth/user_auth_implementation/firebase_auth_services.dart';

class SignInScreenn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuthService authService = FirebaseAuthService();

  SignInScreenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignIn Authentication"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  authService.signIn(context);
                },
                child: const Text(
                  "Sign In",
                ))
          ],
        ),
      ),
    );
  }
}
