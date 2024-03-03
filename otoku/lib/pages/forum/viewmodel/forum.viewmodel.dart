import 'package:flutter/material.dart';
import 'package:otoku/pages/forum/screen/topic.screen.dart';
import 'package:otoku/utils/pageroutes.dart';

class ForumTopic extends StatelessWidget {
  final IconData icon;
  final String title;
  final String author;
  final String date;
  final doc;
  final user;
  ForumTopic(
      {required this.icon,
      required this.title,
      required this.author,
      required this.date,
      required this.doc,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text('Açan: $author - Tarih: $date'),
      onTap: () {
        PageNavigator.push(
            context,
            ForumTopicScreen(
              doc: doc,
              user: user,
            ));
      },
    );
  }
}

class ForumSection extends StatelessWidget {
  final String title;
  final List<ForumTopic> topics;

  ForumSection({
    required this.title,
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
    List<ForumTopic> uniqueTopics = [];

    for (var topic in topics) {
      if (!uniqueTopics.any((t) => t.title == topic.title)) {
        uniqueTopics.add(topic);
      }
    }

    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...uniqueTopics, // Tekrar etmeyen konuları listeye ekler
      ],
    );
  }
}
