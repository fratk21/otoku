import 'package:flutter/material.dart';
import 'package:otoku/pages/forum/screen/topic.screen.dart';
import 'package:otoku/utils/pageroutes.dart';

class ForumTopic extends StatelessWidget {
  final IconData icon;
  final String title;
  final String author;
  final String date;

  ForumTopic({
    required this.icon,
    required this.title,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text('Açan: $author - Tarih: $date'),
      onTap: () {
        PageNavigator.push(context, ForumTopicScreen());
      },
    );
  }
}

class ForumSection extends StatelessWidget {
  final String title;
  final List<Widget> topics;

  ForumSection({
    required this.title,
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
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
        ...topics, // Konuları listeye ekler
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('Daha Fazla Göster'),
            ),
          ],
        ),
      ],
    );
  }
}
