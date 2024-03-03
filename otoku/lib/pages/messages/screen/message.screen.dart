import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/pages/messages/viewmodel/message.viewmodel.dart';
import 'package:otoku/services/addmessagess.services.dart';

class messagesscreen extends StatefulWidget {
  const messagesscreen({Key? key}) : super(key: key);

  @override
  State<messagesscreen> createState() => _messagesscreenState();
}

class _messagesscreenState extends State<messagesscreen> {
  final FirestoreServicemess _firestoreService = FirestoreServicemess();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: _firestoreService.getChatRooms(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var chatRooms = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (BuildContext context, int index) {
              var chatRoom = chatRooms[index];
              var lastMessage = chatRoom['last_message'];

              return ListTile(
                title: Text(chatRoom['recipient_name']),
                subtitle: Text(lastMessage['text']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        chatRoomId: chatRoom.id,
                        recipientName: chatRoom['recipient_name'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String chatRoomId;
  final String recipientName;

  ChatScreen({required this.chatRoomId, required this.recipientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipientName),
      ),
      body: StreamBuilder(
        stream: FirestoreServicemess().getMessages(chatRoomId),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var messages = snapshot.data!.docs;

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              var message = messages[index];

              return ListTile(
                title: Text(message['sender_name']),
                subtitle: Text(message['text']),
              );
            },
          );
        },
      ),
    );
  }
}
