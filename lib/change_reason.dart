import 'package:bluetooth_test_beacon_app/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({ Key? key }) : super(key: key);

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  var nameController = TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final ref1 = FirebaseDatabase.instance
      .ref()
      .child;

  void getName(String reason) async {
    final Map<String, Map> updates = {};
    await ref1('users/$uid').update({
      'wyli': reason,
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change name"),
        backgroundColor: const Color.fromRGBO(33, 97, 170, 1.0),
      ),
      body: Column(
        children:[
          TextField(
              maxLength: 43,
              controller: nameController,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText:'The reason',
              )
          ),
          ElevatedButton(
              child: const Text("State your reason to like the book"),
              onPressed: () {
                getName(nameController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainPage()),
                );
              }
          )
        ],

      ),
    );
  }
}


