import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/message_screen/comps/animated-dialog.dart';
import 'package:otoku/pages/message_screen/comps/styles.dart';

class ChatWidgets {
  static Widget card({title, time, subtitle, onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(5),
          leading: const Padding(
            padding: EdgeInsets.all(0.0),
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                )),
          ),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(time),
          ),
        ),
      ),
    );
  }

  static Widget circleProfile(String username, String profilimage, {onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(profilimage),
              radius: 25,
            ),
            SizedBox(
                width: 50,
                child: Center(
                    child: Text(
                  username,
                  style:
                      TextStyle(height: 1.5, fontSize: 12, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                )))
          ],
        ),
      ),
    );
  }

  Widget messagesCard(sendermail, snap) {
    bool check = snap["messageOwnerMail"].toString() == sendermail;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (check) Spacer(),
          if (!check)
            CircleAvatar(
              child: Icon(
                Icons.ac_unit,
                size: 13,
                color: Colors.red,
              ),
              backgroundColor: Colors.grey,
              radius: 10,
            ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250),
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              child: Text(
                '${snap["message"].toString()}\n\n${snap["timeToSent"].toString()}',
                style: TextStyle(color: check ? Colors.white : Colors.black),
              ),
              decoration: Styles.messagesCardStyle(check),
            ),
          ),
          if (check)
            CircleAvatar(
              child: Icon(
                Icons.abc,
                size: 13,
                color: Colors.red,
              ),
              backgroundColor: Colors.grey,
              radius: 10,
            ),
          if (!check) Spacer(),
        ],
      ),
    );
  }

  messageField({required onSubmit}) {
    final con = TextEditingController();
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextField(
        controller: con,
        decoration: Styles.messageTextFieldStyle(onSubmit: () {
          onSubmit(con);
        }),
      ),
      decoration: Styles.messageFieldCardStyle(),
    );
  }

  static searchBar(
    bool open,
  ) {
    return AnimatedDialog(
      height: open ? 800 : 0,
      width: open ? 400 : 0,
    );
  }

  static searchField({Function(String)? onChange}) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: Styles.messageFieldCardStyle(),
      child: TextField(
        onChanged: onChange,
        decoration: Styles.searchTextFieldStyle(),
      ),
    );
  }
}
