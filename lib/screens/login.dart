import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_chan/screens/createPost.dart';

class LoginPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static const routeName = "/loginPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x1e1e1e),
      appBar: AppBar(
        title: Text("Log In"),
      ),
      body: LogInBody(),
    );
  }
}

class LogInBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 12),
          Text(
            "Enter your credentials to post content on this app",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xff2c2c2c),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter email",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xff2c2c2c),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Password",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              MaterialButton(
                onPressed: () {
                  signInUser(context);
                },
                color: Color(0xff2c2c2c),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard,
                        color: Colors.green.shade200,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "AUTHENTICATE",
                        style: TextStyle(color: Colors.green.shade200),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> signInUser(BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: "barry.allen@example.com", password: "SuperSecretPassword");
    print("Sign in success");
    Navigator.pop(context);
    Navigator.pushNamed(context, CreatePostPage.routeName);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
