import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterweb/phone_auth/screen/signup_phone_screen.dart';

class FirebaseAuthServce {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void phoneSignUp() async {
    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
    }

    verificationFailed(FirebaseAuthException e) {
      print('${e.message}');
    }

    codeSent(String verificationId, int? resendToken) async {
      // Update the UI - wait for the user to enter the SMS code
    }

    codeAutoRetrievalTimeout(String verificationId) {
      // Auto-resolution timed out...
    }

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: SignUpPhoneScreen().phoneController.text,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
}
