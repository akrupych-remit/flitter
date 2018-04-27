import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

import 'message.dart';

class ComposeScreen extends StatefulWidget {
  @override
  _ComposeScreenState createState() => new _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {

  File image;
  TextEditingController inputController = new TextEditingController(text: null);

  Future sendToFirebase() => uploadImage().then((imageUrl) => postMessage(imageUrl));

  Future<String> uploadImage() {
    if (image == null) return Future.value(null);
    String fileName = basename(image.path);
    return FirebaseStorage.instance.ref().child("images/$fileName").putFile(image).future
          .then((snapshot) { return snapshot.downloadUrl.toString(); });
  }

  Future postMessage(String imageUrl) {
    Message message = Platform.isAndroid ? new AndroidBotMessage() : new IOSBotMessage();
    message.text = inputController.text;
    message.imageUrl = imageUrl;
    return FirebaseDatabase.instance.reference().child("messages").push().set(message.toMap());
  }

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
                  ImagePicker.pickImage(source: ImageSource.camera).then((file) {
                    setState(() { image = file; });
                  });
                }),
            IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () {
                  ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
                    setState(() { image = file; });
                  });
                }),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: image != null
                    ? Container(
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(8.0),
                          image: DecorationImage(
                              image: new FileImage(image),
                              fit: BoxFit.fitWidth
                          )
                      ))
                    : Container(),
              )
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                autofocus: true,
                controller: inputController,
                decoration: InputDecoration(
                    hintText: "Type text here",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        sendToFirebase().then((foo) => Navigator.pop(context));
                      },
                    )),
              ),
            )
          ],
        ),
      );
}
