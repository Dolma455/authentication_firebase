import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/signin_auth/screen/draft.dart';
import 'package:flutterweb/signin_auth/screen/signin_screen.dart';

class FirebaseAuthService {
  Future<void> signIn(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: SignInScreenn().emailController.text,
        password: SignInScreenn().passwordController.text,
      );

      User user = userCredential.user!;

      print('User ID: ${user.uid}');
      print('User Email: ${user.email}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(user: user),
        ),
      );
    } catch (e) {
      print('Error signing in: $e');
    }
  }
}
