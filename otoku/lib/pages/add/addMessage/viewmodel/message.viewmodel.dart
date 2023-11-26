import 'package:flutter/material.dart';
import 'package:otoku/pages/messages/screen/chatroom.screen.dart';

class Messageuser {
  final String senderPhoto;
  final String senderName;

  Messageuser({
    required this.senderPhoto,
    required this.senderName,
  });
}

class MessageUserList extends StatelessWidget {
  final Messageuser message;

  MessageUserList({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chatroom(),
                ));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:
                      AssetImage('assets/image/${message.senderPhoto}'),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.senderName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
