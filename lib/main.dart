import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD9k_6i94Hapz_MS1eg1xOSB97Nk8Nivgc',
      authDomain: 'flutterweb-968c2.firebaseapp.com',
      projectId: 'flutterweb-968c2',
      storageBucket: 'flutterweb-968c2.appspot.com',
      messagingSenderId: '225378996225',
      appId: '1:225378996225:web:f43302d799e327f5953000',
    ),
  );
  runApp(const MyApp());
}
