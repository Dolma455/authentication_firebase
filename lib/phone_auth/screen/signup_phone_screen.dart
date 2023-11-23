import 'package:flutter/material.dart';



import 'package:flutterweb/sign_up_auth/validation/signup_validation.dart';

class SignUpPhoneScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpPhoneScreen({super.key});

  void _submitPhoneNumber() {

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
                  // ElevatedButton(
                  // onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  //   int phone = phoneController.text as int;
                  //   String password = passwordController.text;
                  //   try {
                  //     UserCredential userCredential = await auth.phoneSignUp();

                  //     print('User signed up: ${userCredential.user}');
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) =>
                  //                 SignUpPhoneHomeScreen(phone: phone)));
                  //   } catch (e) {
                  //     print('Sign up failed: $e');
                  //   }
                  // }
                  //  },
                  //child: const Text("Sign Up"),
                  //),
                  TextButton(
                    onPressed: _submitPhoneNumber,
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
                            onPressed: () {},
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
                        // try {
                        //   UserCredential userCredential =
                        //       await authService.googleSignIn();
                        //   print(
                        //       'User signed up and signed in with Google: ${userCredential.user}');
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => SignUpHomeScreen(
                        //               email: userCredential.user!.email!)));
                        // } catch (e) {
                        //   print("Sign up with google failed:$e");
                        // }
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
