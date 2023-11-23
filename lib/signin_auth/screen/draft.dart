

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';



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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Sign In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInScreen({super.key});

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Authentication successful, you can access the user information
      User user = userCredential.user!;

      // Now you can use 'user' to get information about the signed-in user
      print('User ID: ${user.uid}');
      print('User Email: ${user.email}');

      // Navigate to the home screen or perform any other action after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(user: user),
        ),
      );
    } catch (e) {
      // Handle sign-in errors
      print('Error signing in: $e');
      // You can show an error message to the user or handle the error in a different way
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(context),
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.email}!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
               
                // Perform sign out or navigate to another screen
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
