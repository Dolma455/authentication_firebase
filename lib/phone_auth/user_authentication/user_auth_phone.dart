import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebasePhoneAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    return _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = '';
          smsCode = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Enter verification code"),
                  content: TextField(
                    onChanged: (value) {
                      smsCode = value;
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("OK"),
                    )
                  ],
                );
              });
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          await _auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }
}
