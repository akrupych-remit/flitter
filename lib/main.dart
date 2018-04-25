import 'dart:io' show Platform;

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flitter/message.dart';
import 'package:flutter/material.dart';
// import DB classes
// auto-animated ListView listening DB changes

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
  // reference to node "messages" in connected DB
  DatabaseReference messages =
      FirebaseDatabase.instance.reference().child("messages");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flitter"),
      ),
      body: new FirebaseAnimatedList(
          // DB reference
          query: messages,
          // show newest on top
          sort: (first, second) => new Message.fromSnapshot(second)
              .timestamp
              .compareTo(new Message.fromSnapshot(first).timestamp),
          // ListView adapter
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            // parse DB object
            Message message = new Message.fromSnapshot(snapshot);
            // make new items appear and deleted ones disappear with animation
            return new SizeTransition(
              sizeFactor: animation,
              // use default ListView item widget
              child: new ListTile(
                leading: new CircleAvatar(
                    backgroundImage: new NetworkImage(message.userImage)),
                title: new Text(message.text),
                subtitle: new Text(message.userName),
              ),
            );
          }),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          messages.push().set(Platform.isAndroid
              ? new AndroidBotMessage().toMap()
              : new IOSBotMessage().toMap());
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
