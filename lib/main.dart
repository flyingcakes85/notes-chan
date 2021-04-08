import 'package:flutter/material.dart';
import 'package:notes_chan/details.dart';
import 'package:notes_chan/screens/content.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Details.APP_NAME,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        backgroundColor: Color(0x1e1e1e),
        drawer: Container(
          height: double.infinity,
          child: Text("oe"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green.shade200,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(Details.APP_NAME),
          actions: [
            IconButton(icon: Icon(Icons.info_outline), onPressed: () {})
          ],
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
      ),
    );
  }
}
