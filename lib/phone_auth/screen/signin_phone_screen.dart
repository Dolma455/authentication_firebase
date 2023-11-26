// import 'package:flutter/material.dart';

// import 'package:flutterweb/phone_auth/user_authentication/user_auth_phone.dart';

// class SignInPhoneScreen extends StatelessWidget {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final FirebasePhoneAuth phoneAuth = FirebasePhoneAuth();
//   SignInPhoneScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign in with Phone"),
//       ),
//       body: Form(
//           key: _formKey,
//           child: Center(
//             child: Container(
//               height: 500,
//               width: 500,
//               color: Colors.blue[100],
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     TextFormField(
//                       controller: phoneController,
//                       decoration: const InputDecoration(
//                         hintText: "phone",
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     TextField(
//                       controller: passwordController,
//                       decoration: const InputDecoration(
//                         hintText: "password",
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     ElevatedButton(
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             String phone = "+977${phoneController.text}";
//                             String password = passwordController.text;
//                             try {
//                               await phoneAuth.signInPhone(
//                                   password, phone, context);
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) =>
//                               //             const SignInPhoneHomeScreen()));
//                             } catch (e) {
//                               print(e);
//                             }
//                           }
//                         },
//                         child: const Text("Sign In")),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutterweb/phone_auth/screen/sms_code_input_screen.dart';

class SignInPhoneScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter your phone number')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: phoneController,
              decoration: InputDecoration(hintText: 'Enter your phone number'),
            ),
            ElevatedButton(
              onPressed: () {
                final String phoneNumber = phoneController.text.trim();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SmsCodeInputScreen(phoneNumber: phoneNumber),
                ));
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}