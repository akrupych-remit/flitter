import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'compose.dart';
import 'message.dart';

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

  Future triggerBot() async {
    messages.push().set(Platform.isAndroid
        ? new AndroidBotMessage().toMap()
        : new IOSBotMessage().toMap());
  }

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
            // make new items appear and deleted ones disappear with animation
            return new SizeTransition(
              sizeFactor: animation,
              // replace ListTile with a custom widget
              child: new MessageWidget(
                  message: new Message.fromSnapshot(snapshot)),
            );
          }),
      floatingActionButton: new FloatingActionButton(
        onPressed: () =>
            MaterialPageRoute(builder: (context) => ComposeScreen()),
        child: new Icon(Icons.add),
      ),
    );
  }
}
