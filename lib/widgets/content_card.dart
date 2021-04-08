import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final String postTopic;
  final String postAuthor;
  final String postContent;
  ContentCard({this.postAuthor, this.postContent, this.postTopic});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(16),
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  postTopic,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  postAuthor,
                  style: TextStyle(fontWeight: FontWeight.w100),
                ),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
                child: Text(
              postContent,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )),
          ],
        ),
      ),
    );
  }
}
