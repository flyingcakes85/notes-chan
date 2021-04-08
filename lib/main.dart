import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_chan/details.dart';
import 'package:notes_chan/screens/content.dart';
import 'package:notes_chan/screens/createPost.dart';
import 'package:notes_chan/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Details.APP_NAME,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
      themeMode: ThemeMode.dark,
      home: HomeContent(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        CreatePostPage.routeName: (context) => CreatePostPage(),
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x1e1e1e),
      drawer: Container(
        height: double.infinity,
        child: Text("Some Text"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleLogIn(context);
        },
        backgroundColor: Colors.green.shade200,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(Details.APP_NAME),
        actions: [IconButton(icon: Icon(Icons.info_outline), onPressed: () {})],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Latest Posts",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 20,
            ),
            Content(),
          ],
        ),
      ),
    );
  }
}

Future<void> _handleLogIn(BuildContext context) async {
  // FirebaseAuth.instance.authStateChanges().listen((User user) {
  //   if (user == null) {
  //     Navigator.pushNamed(context, LoginPage.routeName);
  //   } else {
  //     Navigator.pushNamed(context, CreatePostPage.routeName);
  //   }
  // });
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    Navigator.pushNamed(context, LoginPage.routeName);
  } else {
    Navigator.pushNamed(context, CreatePostPage.routeName);
  }
}
