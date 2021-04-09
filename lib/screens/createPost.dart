import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_chan/consts.dart';

class CreatePostPage extends StatefulWidget {
  CreatePostPage({this.app});
  final FirebaseApp app;

  static const routeName = "/createPostPage";

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  String selectedCourse = Consts.COURSES.elementAt(0);

  final referenceDatabase = FirebaseDatabase.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final db = referenceDatabase.reference();

    TextEditingController postContent = TextEditingController();

    var user = FirebaseAuth.instance.currentUser;
    String userEmail = user.email.toString();
    String userName = "";

    for (var i = 0; i < userEmail.length; i++) {
      if (userEmail[i] == '@') {
        break;
      }
      userName = userName + userEmail[i];
    }

    return Scaffold(
      backgroundColor: Color(0x1e1e1e),
      appBar: AppBar(
        title: Text("Create Post"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logOut();
                Navigator.pop(context);
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 14, left: 24, right: 24, bottom: 18),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SELECT COURSE",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedCourse,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 18,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.green.shade200,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCourse = newValue;
                    });
                  },
                  items: Consts.COURSES
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(0xff2c2c2c),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: postContent,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type Post",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(child: Container(), flex: 1),
                MaterialButton(
                  onPressed: () {
                    print(userName);
                    Map<String, String> data = {
                      'course': selectedCourse,
                      'body': postContent.text,
                      'author': userName.toUpperCase(),
                    };
                    db
                        .push()
                        .set(data,
                            priority:
                                (0 - DateTime.now().millisecondsSinceEpoch))
                        .then((value) => print("stored"));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color(0xff2c2c2c),
                        elevation: 8,
                        content: Row(
                          children: [
                            Icon(
                              Icons.done,
                              color: Colors.green.shade200,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Post Created!",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )));
                    postContent.clear();
                  },
                  color: Color(0xff2c2c2c),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pages,
                          color: Colors.green.shade200,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "POST",
                          style: TextStyle(color: Colors.green.shade200),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container(), flex: 1),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> logOut() async {
  await FirebaseAuth.instance.signOut();
}
