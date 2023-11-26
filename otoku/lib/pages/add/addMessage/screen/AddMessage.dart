import 'package:flutter/material.dart';
import 'package:otoku/pages/add/addMessage/viewmodel/message.viewmodel.dart';

class AddmessageScreen extends StatefulWidget {
  const AddmessageScreen({super.key});

  @override
  State<AddmessageScreen> createState() => _AddmessageScreenState();
}

class _AddmessageScreenState extends State<AddmessageScreen> {
  final List<Messageuser> messages = [
    Messageuser(
      senderPhoto: 'anime.png',
      senderName: 'John Doe',
    ),
    Messageuser(
      senderPhoto: 'anime.png',
      senderName: 'Jane Smith',
    ),
    // Diğer mesajları burada ekleyin
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return MessageUserList(message: messages[index]);
          },
        ));
  }
}
