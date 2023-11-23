import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/sign_up_auth/screen/sign_in_home_page.dart';
import 'package:flutterweb/sign_up_auth/screen/signup_screen.dart';
import 'package:flutterweb/sign_up_auth/user_auth_implementation/user_auth.dart';
import 'package:flutterweb/sign_up_auth/validation/sign_in_validation.dart';

class SignInScrn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuthServices authService = FirebaseAuthServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignInScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In User"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            color: Colors.blue[100],
            height: 500,
            width: 500,
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
                    validator: SignInValidation.validateEmail,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: SignInValidation.validatePassword,
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
                          UserCredential userCredential = await authService
                              .signInWithEmailAndP(email, password);
                          print('User signed in: ${userCredential.user}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInHomeScreen(
                                        email: email,
                                      )));
                        } catch (e) {
                          print('Sign in failed: $e');
                        }
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.red[300],
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
