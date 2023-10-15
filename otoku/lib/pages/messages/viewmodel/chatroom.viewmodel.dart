import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final DateTime time;
  final String userId;

  ChatMessage({required this.text, required this.time, required this.userId});

  bool get isMe =>
      userId == "user1"; // Kendi mesajınızı sağ tarafta göstermek için kontrol

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isMe)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text(
                    'B'), // Diğer kullanıcının profil resmini burada ekleyebilirsiniz
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isMe
                      ? 'Ben'
                      : 'Kullanıcı Adı', // Kullanıcı adını burada ekleyebilirsiniz
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Text(
                  time.toLocal().toString(), // Mesajın tarihini gösterin
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (isMe)
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                child:
                    Text('A'), // Kendi profil resminizi burada ekleyebilirsiniz
              ),
            ),
        ],
      ),
    );
  }
}
