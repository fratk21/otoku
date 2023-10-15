import 'package:flutter/material.dart';
import 'package:otoku/pages/messages/screen/chatroom.screen.dart';

class Message {
  final String senderPhoto;
  final String senderName;
  final String text;
  final String time;

  Message({
    required this.senderPhoto,
    required this.senderName,
    required this.text,
    required this.time,
  });
}

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble({required this.message});

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
                      Text(
                        message.text.length > 30
                            ? '${message.text.substring(0, 30)}...'
                            : message.text,
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
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
