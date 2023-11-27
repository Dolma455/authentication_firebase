import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/phone_auth/screen/signin_phone_screen.dart';

import 'package:flutterweb/phone_auth/user_authentication/user_auth_phone.dart';

import 'package:flutterweb/sign_up_auth/validation/signup_validation.dart';

class SignUpPhoneScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpPhoneScreen({super.key});

  void _showErrorDialog(BuildContext context, String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _submitPhoneNumber(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebasePhoneAuth()
            .verifyPhoneNumber("+977${phoneController.text}", context);
      } catch (e) {
        _showErrorDialog(context, 'Invalid Format');
      }
    }
  }

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
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: "Phone",
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
                    validator: SignUpValidation.validatePassword,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    onPressed: () {
                      _submitPhoneNumber(context);
                    },
                    child: const Text('Verify Phone Number'),
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
                                      builder: (context) =>
                                          SignInPhoneScreen()));
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
                              await FirebasePhoneAuth().googleSignIn();
                          print(
                              'User signed up and signed in with Google: ${userCredential.user}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPhoneScreen()));
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
