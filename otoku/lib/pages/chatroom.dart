import 'package:flutter/material.dart';
import 'package:otoku/models/pagemodel.dart';

class Chatroom extends StatefulWidget {
  @override
  State createState() => ChatroomState();
}

class ChatroomState extends State<Chatroom> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final String _myUserId =
      "user1"; // Kendi kullanıcı kimliğinizi burada belirtin

  void _handleSubmitted(String text) {
    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      time: DateTime.now(),
      userId: _myUserId,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: "Mesajınızı girin...",
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pagemodel(
        AppBar: AppBar(
          title: Text('Chat Odası'),
        ),
        Widget: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (_, int index) => _messages[index],
              ),
            ),
            Divider(height: 1.0),
            _buildTextComposer(),
          ],
        ));
  }
}

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
