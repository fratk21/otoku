import 'package:flutter/material.dart';
import 'package:otoku/utils/colors.dart';

class ForumTopicCard extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String date;
  final String? title;
  final String content;

  ForumTopicCard({
    required this.profileImageUrl,
    required this.username,
    required this.date,
    this.title,
    required this.content,
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
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
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
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
