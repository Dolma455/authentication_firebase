import 'package:flutter/material.dart';

class VerifyPhoneScreen extends StatelessWidget {
  VerifyPhoneScreen({super.key});
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Phone"),
      ),
      body: Container(
          height: 500,
          width: 500,
          color: Colors.blue[100],
          child: Column(
            children: [
              const Text(
                "Enter the 6-digit code",
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(),
              )
            ],
          )),
    );
  }
}
