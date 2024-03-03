import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/forum/viewmodel/forumTopicCard.Viewmodel.dart';
import 'package:otoku/services/firestore_methods.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/appbarmodel.dart';

class ForumTopicScreen extends StatefulWidget {
  final doc;
  final user;
  const ForumTopicScreen({Key? key, required this.doc, required this.user})
      : super(key: key);

  @override
  _ForumTopicScreenState createState() => _ForumTopicScreenState();
}

class _ForumTopicScreenState extends State<ForumTopicScreen> {
  final TextEditingController _textController = TextEditingController();
  List<String> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.white,
        title: Text(
          "OTOKU FORUM",
          style: TextStyle(
              fontFamily: "BlackOpsOne", fontSize: 30, color: AppColors.orange),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('forum')
                  .doc(widget.doc["forumuid"])
                  .collection('comments')
                  .orderBy('datePublished', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ForumTopicCard(
                          profileImageUrl: widget.user['photoUrl'],
                          username: widget.user['username'],
                          date: widget.doc['timestamp'],
                          title: widget.doc['forumKonu'],
                          content: widget.doc['forumIcerik'],
                          uid: widget.user["uid"],
                        ),
                      ],
                    ),
                  );
                }

                comments = snapshot.data!.docs
                    .map((doc) => doc['description'].toString())
                    .toList();

                var forumKonu = widget.doc['forumKonu'];
                var forumIcerik = widget.doc['forumIcerik'];
                var timestamp = widget.doc['timestamp'];

                // Kullanıcı bilgilerine erişim
                var username = widget.user['username'];
                var profileImageUrl = widget.user['photoUrl'];

                return Column(
                  children: [
                    ForumTopicCard(
                      profileImageUrl: profileImageUrl,
                      username: username,
                      date: timestamp,
                      title: forumKonu,
                      content: forumIcerik,
                      uid: widget.user["uid"],
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ForumTopicCard(
                            profileImageUrl: snapshot
                                .data!.docs[index]["photoUrl"]
                                .toString(),
                            username: snapshot.data!.docs[index]["username"]
                                .toString(),
                            date: snapshot.data!.docs[index]["datePublished"]
                                .toString(),
                            title: snapshot.data!.docs[index]["description"]
                                .toString(),
                            content: "null",
                            uid: snapshot.data!.docs[index]["uid"],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          _buildTextComposer()
        ],
      ),
    );
  }

  void _handleSubmitted(String text) async {
    _textController.clear();
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(
          FirebaseAuth.instance.currentUser!.uid,
        )
        .get();

    await FireStoreMethods().postComment(
      widget.doc["forumuid"],
      text,
      FirebaseAuth.instance.currentUser!.uid,
      userSnap["username"],
      userSnap["photoUrl"],
    );
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
}
