import 'dart:io' show Platform;

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(new MaterialApp(
    title: 'Flitter',
    home: new MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference messages =
      FirebaseDatabase.instance.reference().child("messages");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flitter"),
      ),
      body: new FirebaseAnimatedList(
          query: messages,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) =>
              new SizeTransition(
                sizeFactor: animation,
                child: new ListTile(
                  leading: new CircleAvatar(
                    backgroundImage:
                        new NetworkImage(snapshot.value["userImage"]),
                  ),
                  title: new Text(snapshot.value["text"]),
                  subtitle: new Text(snapshot.value["userName"]),
                ),
              )),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          messages.push().set({
            "userId": Platform.isAndroid ? "android_bot" : "ios_bot",
            "userImage": Platform.isAndroid
                ? "http://files.softicons.com/download/social-media-icons/simple-icons-by-dan-leech/ico/android.ico"
                : "http://www.mobiflip.de/wp-content/uploads/2011/09/apple-logo9.jpg",
            "userName": Platform.isAndroid ? "Android Bot" : "iOS Bot",
            "timestamp": new DateTime.now().millisecondsSinceEpoch,
            "text":
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
          });
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
