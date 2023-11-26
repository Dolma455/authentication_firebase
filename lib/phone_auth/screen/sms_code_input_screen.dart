import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/phone_auth/screen/signin_home_screen.dart';

class SmsCodeInputScreen extends StatefulWidget {
  final String phoneNumber;

  const SmsCodeInputScreen({super.key, required this.phoneNumber});

  @override
  _SmsCodeInputScreenState createState() => _SmsCodeInputScreenState();
}

class _SmsCodeInputScreenState extends State<SmsCodeInputScreen> {
  final TextEditingController smsCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SignInPhoneHomeScreen()));
        // TODO: Navigate to the next screen
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  Future<void> _signInWithSmsCode(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential);
    // TODO: Navigate to the next screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter the SMS code')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: smsCodeController,
              decoration: const InputDecoration(hintText: 'Enter the SMS code'),
            ),
            ElevatedButton(
              onPressed: () {
                final String smsCode = smsCodeController.text.trim();
                _signInWithSmsCode(smsCode);
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
