import 'package:flutter/material.dart';
import 'package:otoku/pages/profile/view/profile.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:random_avatar/random_avatar.dart';

class ForumTopicCard extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String date;
  final String? title;
  final String content;
  final String uid;

  ForumTopicCard({
    required this.profileImageUrl,
    required this.username,
    required this.date,
    this.title,
    required this.content,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      PageNavigator.push(context, profilescreen(uid: uid));
                    },
                    child: RandomAvatar(profileImageUrl, height: 50)),
                SizedBox(width: 8),
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              date,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            title != null ? SizedBox(height: 16) : SizedBox(height: 1),
            title != null
                ? Text(
                    title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : Container(),
            title != null ? SizedBox(height: 16) : SizedBox(height: 1),
            content != "null"
                ? Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
