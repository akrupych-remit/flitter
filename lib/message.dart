import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Message {
  String userId;
  String userName;
  String userImage;
  int timestamp;
  String text;

  Message(
      {this.userId, this.userName, this.userImage, this.timestamp, this.text});

  Message.fromSnapshot(DataSnapshot snapshot) {
    this.userId = snapshot.value["userId"];
    this.userName = snapshot.value["userName"];
    this.userImage = snapshot.value["userImage"];
    this.timestamp = snapshot.value["timestamp"];
    this.text = snapshot.value["text"];
  }

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userName": userName,
        "userImage": userImage,
        "timestamp": timestamp,
        "text": text
      };

  String getFormattedDateTime() {
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat formatter = new DateFormat.yMd().add_jm();
    return formatter.format(dateTime);
  }
}

class AndroidBotMessage extends Message {
  AndroidBotMessage()
      : super(
            userId: "android_bot",
            userName: "Android Bot",
            userImage:
                "http://files.softicons.com/download/social-media-icons/simple-icons-by-dan-leech/ico/android.ico",
            timestamp: new DateTime.now().millisecondsSinceEpoch,
            text:
                "Android Oreo has arrived. Safer, smarter, more powerful & sweeter than ever.");
}

class IOSBotMessage extends Message {
  IOSBotMessage()
      : super(
            userId: "ios_bot",
            userName: "iOS Bot",
            userImage:
                "http://www.mobiflip.de/wp-content/uploads/2011/09/apple-logo9.jpg",
            timestamp: new DateTime.now().millisecondsSinceEpoch,
            text:
                "Our vision has always been to create an iPhone that is entirely screen. One so immersive the device itself disappears into the experience. And so intelligent it can respond to a tap, your voice, and even a glance. With iPhone X, that vision is now a reality. Say hello to the future.");
}

// here's what a typical layout looks like
class MessageWidget extends StatelessWidget {
  final Message message;

  MessageWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: new Card(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(message.userImage),
                  ),
                ),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      message.userName,
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      message.getFormattedDateTime(),
                      style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
            new Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: new Text(
                message.text,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
