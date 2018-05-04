import 'package:flutter/material.dart';
import 'message.dart';
import 'package:share/share.dart';
import 'utils.dart';

class DetailsPage extends StatelessWidget {

  final Message message;

  DetailsPage({ this.message });

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text("Message"),
      actions: isIos(context)
        ? <Widget>[
          new IconButton(
              icon: new Icon(Icons.share),
              onPressed: _shareMessage
          )
        ]
        : null
    ),
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
    floatingActionButton: isAndroid(context)
      ? new FloatingActionButton(
        child: new Icon(Icons.share),
        onPressed: _shareMessage
      )
      : null
  );

  _shareMessage() => share(message.getContentForSharing());
}