import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/sign_up_auth/screen/sign_up_home_screen.dart';
import 'package:flutterweb/sign_up_auth/screen/sign_in_screen.dart';

import 'package:flutterweb/sign_up_auth/user_auth_implementation/user_auth.dart';
import 'package:flutterweb/sign_up_auth/validation/signup_validation.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuthServices authService = FirebaseAuthServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up User"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            height: 500,
            width: 500,
            color: Colors.blue[100],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "email",
                    ),
                    validator: SignUpValidation.validateEmail,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: SignUpValidation.validatePassword,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String email = emailController.text;
                        String password = passwordController.text;
                        try {
                          UserCredential userCredential =
                              await authService.signUp(email, password);
                          print('User signed up: ${userCredential.user}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpHomeScreen(
                                        email: email,
                                      )));
                        } catch (e) {
                          print('Sign up failed: $e');
                        }
                      }
                    },
                    child: const Text("Sign Up"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScrn()));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.red[300],
                              ),
                            ))
                      ]),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("or"),
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                      onPressed: () async {
                        try {
                          UserCredential userCredential =
                              await authService.googleSignIn();
                          print(
                              'User signed up and signed in with Google: ${userCredential.user}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpHomeScreen(
                                      email: userCredential.user!.email!)));
                        } catch (e) {
                          print("Sign up with google failed:$e");
                        }
                      },
                      child: const Text("Continue with Google")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
