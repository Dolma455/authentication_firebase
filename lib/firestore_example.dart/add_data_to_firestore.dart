import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePAge extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String? phone;

  MyHomePAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              phone = value;
            },
            decoration: const InputDecoration(
              hintText: "Enter phone",
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await users.add({
                  'name': 'Ram',
                  'age': phone,
                  'note': 'Hello',
                }).then((value) => print(
                      "user added",
                    ));
              },
              child: const Text(
                "Submit",
              ))
        ],
      ),
    );
  }
}
