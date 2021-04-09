import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:notes_chan/widgets/content_card.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  static var sampleData = [
    [
      "Programming",
      "intrastellar",
      "Here\'s some code you need to run right now. Increases your marks by 500%"
    ],
    [
      "Discord",
      "Fern Senpai",
      "Everyone make sure to claim your daily coins. You don't wanna ruin that streak, do you?"
    ],
    [
      "Discord",
      "IntraDog",
      "Ruff Ruff",
    ],
    [
      "Physics",
      "Lens",
      "Some Notes here. Gonna be useful for that exam we have next decade.",
    ],
    [
      "Discord",
      "Ryuk",
      "Who took my apple?",
    ]
  ];

  final referenceDatabase = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    DatabaseReference db = referenceDatabase.reference();
    // return Expanded(
    //   child: ListView.separated(
    //     separatorBuilder: (BuildContext context, int index) {
    //       return SizedBox(height: 9);
    //     },
    //     itemCount: sampleData.length,
    //     itemBuilder: (context, index) {
    //       return ContentCard(
    //         postTopic: sampleData.elementAt(index).elementAt(0),
    //         postAuthor: sampleData.elementAt(index).elementAt(1),
    //         postContent: sampleData.elementAt(index).elementAt(2),
    //       );
    //     },
    //   ),
    // );

    return Flexible(
        child: FirebaseAnimatedList(
      query: db,
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        return ContentCard(
          postTopic: snapshot.value['course'],
          postAuthor: snapshot.value['author'],
          postContent: snapshot.value['body'],
        );
      },
    ));
  }
}
