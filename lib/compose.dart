import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    title: "Compose Message",
    home: ComposeScreen(),
  ));
}

class ComposeScreen extends StatefulWidget {
  @override
  _ComposeScreenState createState() => new _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  File image;

  void sendMessage() {}

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text("Compose message"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {
                  ImagePicker
                      .pickImage(source: ImageSource.camera)
                      .then((file) {
                    setState(() {
                      image = file;
                    });
                  });
                }),
            IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () {
                  ImagePicker
                      .pickImage(source: ImageSource.gallery)
                      .then((file) {
                    setState(() {
                      image = file;
                    });
                  });
                }),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: image != null
                  ? Image.file(
                      image,
                      fit: BoxFit.fitWidth,
                    )
                  : Container(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: "Type text here",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: sendMessage,
                    )),
              ),
            )
          ],
        ),
      );
}
