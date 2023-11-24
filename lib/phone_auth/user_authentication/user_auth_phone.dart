import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/phone_auth/screen/signin_home_screen.dart';
import 'package:flutterweb/phone_auth/screen/signup_home_screen.dart';

import 'package:google_sign_in/google_sign_in.dart';

class FirebasePhoneAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          "225378996225-r7ccdble1fmseb004ecagvdoum0nks9a.apps.googleusercontent.com");

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    return _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Error"),
                  content: Text("Invalid Format"),
                );
              });
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          String? smsCode = '';
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
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
                        onPressed: () {
                          Navigator.of(context).pop(smsCode);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignUpPhoneHomeScreen()));
                        },
                        child: const Text("OK"),
                      )
                    ],
                  );
                }).then((value) {
              smsCode = value ?? '';
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: smsCode!,
              );
              _auth.signInWithCredential(credential);
            });
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  Future<void> signInPhone(
      String smsCode, String verificationId, BuildContext context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SignInPhoneHomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        _showErrorDialog(context, 'Invalid code');
      } else {
        _showErrorDialog(context, 'An unknown error occured');
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  Future<UserCredential> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }
}
