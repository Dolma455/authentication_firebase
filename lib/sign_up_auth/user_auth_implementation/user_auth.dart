import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          "225378996225-r7ccdble1fmseb004ecagvdoum0nks9a.apps.googleusercontent.com");

  void showErrorDialog(BuildContext context, String message) {
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
                  child: const Text("OK"))
            ],
          );
        });
  }

  Future<UserCredential> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = _firebaseAuth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorDialog(context, "The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        showErrorDialog(context, "The account already exists for that email");
      }
      rethrow;
    } catch (e) {
      showErrorDialog(context, e.toString());
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmailAndP(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      if (user != null && !user.emailVerified) {
        await _firebaseAuth.signOut();

        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before signing in.',
        );
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorDialog(context, "Sorry, Can not find user");
      } else if (e.code == 'wrong-password') {
        showErrorDialog(context, "Wrong Password");
      } else if (e.code == 'email-not-verified') {
        showErrorDialog(context, e.message.toString());
      }
      rethrow;
    } catch (e) {
      showErrorDialog(context, e.toString());
      rethrow;
    }
  }

  Future<UserCredential> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }
}
