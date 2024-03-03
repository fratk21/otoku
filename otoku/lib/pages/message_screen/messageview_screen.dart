import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/message_screen/comps/styles.dart';
import 'package:otoku/services/firestore_methods.dart';
import 'package:otoku/widgets/indicator.dart';
import 'package:otoku/widgets/post_card_message.dart';
import 'package:random_avatar/random_avatar.dart';

class ChatPage extends StatefulWidget {
  final String uid;

  const ChatPage({
    super.key,
    required this.uid,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var messagesearch;
  String me = "";
  bool newmessage = true;
  int messagelenght = 0;
  String messageroomid = "";
  List messageroompeaple = [];
  String receivermail = "";
  String receiverprofileimage = "";
  String receiverusername = "";
  String sendermail = "";
  String senderprofileimage = "";
  String senderusername = "";
  String senderuid = "";
  int loading = 0;
  final con = TextEditingController();
  Future gel() async {
    loading = 0;
    var receiver = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .get();
    var me = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    receivermail = receiver.data()!["email"];
    receiverprofileimage = receiver.data()!["photoUrl"];
    receiverusername = receiver.data()!["username"];
    sendermail = me.data()!["email"];
    senderprofileimage = me.data()!["photoUrl"];
    senderusername = me.data()!["username"];
    senderuid = me.data()!["uid"];
    messageroompeaple.add(widget.uid);
    messageroompeaple.add(FirebaseAuth.instance.currentUser?.uid);
    var messagebool = await FirebaseFirestore.instance
        .collection("message")
        .where("receiveruid", isEqualTo: widget.uid)
        .where("senderuid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    var deneme = await FirebaseFirestore.instance
        .collection("message")
        .where("senderuid", isEqualTo: widget.uid)
        .where("receiveruid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    print(messagebool.docs.length);
    print(deneme.docs.length);

    if (messagebool.docs.isEmpty && deneme.docs.isEmpty) {
      newmessage = true;
    } else {
      newmessage = false;
      if (messagebool.docs.isEmpty) {
        messageroomid = deneme.docs.first.id.toString();
        print(messageroomid);
        messagesearch = await FirebaseFirestore.instance
            .collection('message')
            .doc(messageroomid)
            .collection('chat')
            .get();

        messagelenght = messagesearch.docs.length;
      } else {
        messageroomid = messagebool.docs.first.id.toString();
        print(messageroomid);
        messagesearch = await FirebaseFirestore.instance
            .collection('message')
            .doc(messageroomid)
            .collection('chat')
            .get();

        messagelenght = messagesearch.docs.length;
      }
    }
    print(newmessage);

    print(messagebool.docs.length);
    loading = 1;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gel();
  }

  @override
  Widget build(BuildContext context) {
    FireStoreMethods _fireStoreMethods = FireStoreMethods();

    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      appBar: loading == 0
          ? AppBar(title: Center(child: CircularProgressIndicator()))
          : AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.indigo.shade400,
              title: Row(
                children: [
                  RandomAvatar(receiverprofileimage.toString(), height: 50),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(receiverusername),
                ],
              ),
              elevation: 0,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
              ],
            ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: Styles.friendsBox(),
              child: messageroomid == ""
                  ? Container()
                  : loading == 0
                      ? CustomProgressIndicator()
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('message')
                              .doc(messageroomid)
                              .collection('chat')
                              .orderBy("timeToSent", descending: true)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return Postcard_message(
                                  receiverprofileimage: receiverprofileimage,
                                  senderprofileimage: senderprofileimage,
                                  sendermail: sendermail,
                                  snap: snapshot.data!.docs[index].data(),
                                );
                              },
                            );
                          },
                        ),
            ),
          ),
          Container(
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: Styles.messageFieldCardStyle(),
                child: TextField(
                  controller: con,
                  decoration: Styles.messageTextFieldStyle(onSubmit: () async {
                    _fireStoreMethods.uploadnewmessage(
                        newmessage,
                        messageroompeaple,
                        con.text,
                        receivermail,
                        receiverprofileimage,
                        widget.uid,
                        receiverusername,
                        sendermail,
                        senderprofileimage,
                        senderuid,
                        senderusername);

                    //////////////////////
                    var messagebool = await FirebaseFirestore.instance
                        .collection("message")
                        .where("receiveruid", isEqualTo: widget.uid)
                        .where("senderuid",
                            isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                        .get();
                    var deneme = await FirebaseFirestore.instance
                        .collection("message")
                        .where("senderuid", isEqualTo: widget.uid)
                        .where("receiveruid",
                            isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                        .get();
                    if (messagebool.docs.isEmpty && deneme.docs.isEmpty) {
                      newmessage = true;
                    } else {
                      newmessage = false;
                      if (messagebool.docs.isEmpty) {
                        messageroomid = deneme.docs.first.id.toString();
                        print(messageroomid);
                        messagesearch = await FirebaseFirestore.instance
                            .collection('message')
                            .doc(messageroomid)
                            .collection('chat')
                            .get();

                        messagelenght = messagesearch.docs.length;
                      } else {
                        messageroomid = messagebool.docs.first.id.toString();
                        print(messageroomid);
                        messagesearch = await FirebaseFirestore.instance
                            .collection('message')
                            .doc(messageroomid)
                            .collection('chat')
                            .get();

                        messagelenght = messagesearch.docs.length;
                      }
                    }
                    setState(() {
                      newmessage;
                      messageroomid;
                      print(messageroomid);
                    });
                    con.clear();
                  }),
                ),
              ))
        ],
      ),
    );
  }
}
