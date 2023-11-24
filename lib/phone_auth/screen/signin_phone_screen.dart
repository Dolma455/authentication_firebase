import 'package:flutter/material.dart';
import 'package:flutterweb/phone_auth/screen/signin_home_screen.dart';
import 'package:flutterweb/phone_auth/user_authentication/user_auth_phone.dart';

class SignInPhoneScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebasePhoneAuth phoneAuth = FirebasePhoneAuth();
  SignInPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in with Phone"),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: "phone",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: "password",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String phone = phoneController.text;
                            String password = passwordController.text;
                            try {
                              await phoneAuth.signInPhone(
                                  phone, password, context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPhoneHomeScreen()));
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: const Text("Sign In")),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
