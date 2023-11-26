import 'package:flutter/material.dart';
import 'package:otoku/pages/forum/viewmodel/forumTopicCard.Viewmodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/appbarmodel.dart';

class ForumTopicScreen extends StatefulWidget {
  const ForumTopicScreen({Key? key}) : super(key: key);

  @override
  _ForumTopicScreenState createState() => _ForumTopicScreenState();
}

class _ForumTopicScreenState extends State<ForumTopicScreen> {
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();

    setState(() {});
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
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                ForumTopicCard(
                  profileImageUrl:
                      'https://marketplace.canva.com/EAFXS8-cvyQ/1/0/400w/canva-brown-and-light-brown%2C-circle-framed-instagram-profile-picture-SsX0UeCGP8g.jpg',
                  username: 'JohnDoe',
                  date: '15 Eylül 2023',
                  title: 'Flutter İle Mobil Uygulama Geliştirme',
                  content: 'dolor sit amet, consectetur adipiscing elit...',
                ),
                ForumTopicCard(
                  profileImageUrl:
                      'https://marketplace.canva.com/EAFXS8-cvyQ/1/0/400w/canva-brown-and-light-brown%2C-circle-framed-instagram-profile-picture-SsX0UeCGP8g.jpg',
                  username: 'asdadsads',
                  date: '15 Eylül 2023',
                  content: 'onsectetur lit...',
                ),
              ],
            ),
          ),
          _buildTextComposer()
        ],
      ),
    );
  }
}
