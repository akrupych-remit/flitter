import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'compose.dart';
import 'message.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Flitter"),
    ),
    body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.reference().child("messages"),
        sort: (first, second) => Message.fromSnapshot(second).timestamp
            .compareTo(Message.fromSnapshot(first).timestamp),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) => SizeTransition(
          sizeFactor: animation,
          child: MessageWidget(message: Message.fromSnapshot(snapshot)),
        )
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ComposeScreen())),
      child: Icon(Icons.add),
    ),
  );
}
