import 'package:flutter/material.dart';
import 'package:otoku/widgets/pagemodel.dart';
import 'package:otoku/pages/messages/viewmodel/message.viewmodel.dart';

class messagesscreen extends StatefulWidget {
  const messagesscreen({super.key});

  @override
  State<messagesscreen> createState() => _messagesscreenState();
}

class _messagesscreenState extends State<messagesscreen> {
  @override
  Widget build(BuildContext context) {
    return ChatScreen();
  }
}

class ChatScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(
      senderPhoto: 'anime.png',
      senderName: 'John Doe',
      text:
          'Merhaba, nasılsın?szdfxcghvbjnkmlölkjhgfdghjklşlkjhgfdghjklşilkjhgfdghkjlşlkjhgfdghjklişkj',
      time: '14:30',
    ),
    Message(
      senderPhoto: 'anime.png',
      senderName: 'Jane Smith',
      text: 'İyi günler!',
      time: '14:35',
    ),
    // Diğer mesajları burada ekleyin
  ];

  @override
  Widget build(BuildContext context) {
    return pagemodel(
        AppBar: AppBar(
          title: Text('Chat'),
          automaticallyImplyLeading: false,
        ),
        Widget: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return MessageBubble(message: messages[index]);
          },
        ));
  }
}
