import 'package:flutter/material.dart';
import 'message.dart';

class DetailsPage extends StatelessWidget {

  final Message message;

  DetailsPage({ this.message });

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(title: new Text("Message")),
    body: new ListView(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new MessageInfoWidget(message: message),
        ),
        new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: new Text(message.text),
        ),
        message.imageUrl != null
            ? new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Hero(
                tag: message.imageUrl.hashCode,
                child: new Image.network(message.imageUrl),
              ),
            )
            : new Container()
      ],
    ),
  );
}