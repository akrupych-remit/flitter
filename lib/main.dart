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
                    title: new Text(
                        "${snapshot.key}: ${snapshot.value.toString()}")),
              )),
    );
  }
}
