import 'package:flutter/material.dart';
import 'package:otoku/models/pagemodel.dart';
import 'package:otoku/pages/messages/viewmodel/chatroom.viewmodel.dart';

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
