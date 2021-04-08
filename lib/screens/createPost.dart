import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePostPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static const routeName = "/createPostPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x1e1e1e),
      appBar: AppBar(
        title: Text("Log In"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logOut();
                Navigator.pop(context);
              }),
        ],
      ),
      body: Text("User logged in"),
    );
  }
}

Future<void> logOut() async {
  await FirebaseAuth.instance.signOut();
}
