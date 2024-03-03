import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:otoku/pages/message_screen/comps/styles.dart';
import 'package:random_avatar/random_avatar.dart';

class Postcard_message extends StatefulWidget {
  final snap;
  final String senderprofileimage;
  final String receiverprofileimage;
  final String? sendermail;
  const Postcard_message({
    Key? key,
    required this.snap,
    required this.sendermail,
    required this.receiverprofileimage,
    required this.senderprofileimage,
  }) : super(key: key);

  @override
  State<Postcard_message> createState() => _Postcard_messageState();
}

class _Postcard_messageState extends State<Postcard_message> {
  @override
  Widget build(BuildContext context) {
    bool check = widget.snap["messageOwnerMail"] == widget.sendermail;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (check) const Spacer(),
          if (!check)
            RandomAvatar(
              widget.receiverprofileimage,
              height: 50,
            ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(10),
              child: Text(
                '${widget.snap["message"].toString()}\n\n${DateFormat.yMMMMd().format(widget.snap["timeToSent"].toDate())}',
                style: TextStyle(color: check ? Colors.white : Colors.black),
              ),
              decoration: Styles.messagesCardStyle(check),
            ),
          ),
          if (check)
            RandomAvatar(
              widget.senderprofileimage,
              height: 50,
            ),
          if (!check) const Spacer(),
        ],
      ),
    );
  }
}
