import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:otoku/pages/message_screen/messageview_screen.dart';
import 'package:random_avatar/random_avatar.dart';

class Postcard_message_view extends StatefulWidget {
  final snap;
  final String username;
  const Postcard_message_view({
    Key? key,
    required this.snap,
    required this.username,
  }) : super(key: key);

  @override
  State<Postcard_message_view> createState() => _Postcard_message_viewState();
}

class _Postcard_message_viewState extends State<Postcard_message_view> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatPage(
                    uid: widget.snap["receiveruid"] ==
                            FirebaseAuth.instance.currentUser?.uid
                        ? widget.snap["senderuid"]
                        : widget.snap["receiveruid"]),
              ),
            );
          },
          contentPadding: const EdgeInsets.all(5),
          leading: Padding(
              padding: EdgeInsets.all(0.0),
              child: RandomAvatar(
                  widget.snap["receiveruid"] ==
                          FirebaseAuth.instance.currentUser?.uid
                      ? widget.snap["senderprofileimage"].toString()
                      : widget.snap["receiverprofileimage"].toString(),
                  height: 50)),
          title: widget.snap["receiveruid"] ==
                  FirebaseAuth.instance.currentUser?.uid
              ? Text(widget.snap["senderusername"].toString())
              : Text(widget.snap["receiverusername"].toString()),
          subtitle: widget.snap["lastmessage"] != null
              ? Text(widget.snap["lastmessage"])
              : null,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(DateFormat.yMMMMd()
                .format(widget.snap["lastmessagetime"].toDate())
                .toString()),
          ),
        ),
      ),
    );
  }
}
