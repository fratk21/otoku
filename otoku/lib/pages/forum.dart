import 'package:flutter/material.dart';
import 'package:otoku/models/appbarmodel.dart';
import 'package:otoku/models/pagemodel.dart';
import 'package:otoku/models/textmodels.dart';
import 'package:otoku/utils/colors.dart';

class forumscreen extends StatefulWidget {
  const forumscreen({super.key});

  @override
  State<forumscreen> createState() => _forumscreenState();
}

class _forumscreenState extends State<forumscreen> {
  @override
  Widget build(BuildContext context) {
    return pagemodel(
      AppBar: CustomAppBar(
        height: 120,
        centerTitle: false,
        autoleading: false,
        backgroundColor: white,
        title: Text(
          "OTOKU FORUM",
          style:
              TextStyle(fontFamily: "BlackOpsOne", fontSize: 30, color: orange),
        ),
        preferredSizeWidget: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Radiuslu olacak
                  border: Border.all(
                      color: Colors.black, width: 1), // İnce ve siyah border
                ),
                child: Row(
                  children: [
                    Icon(Icons.search), // Büyüteç ikonu
                    SizedBox(width: 10), // İkon ile metin arasındaki boşluk
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border:
                              InputBorder.none, // Dışarıdaki border'ı kaldır
                          hintText:
                              'Forumda arama yapın...', // Varsayılan metin
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      Widget: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ForumSection(
                    title: 'En Popüler Konular',
                    topics: [
                      ForumTopic(
                        icon: Icons.star,
                        title: 'Flutter İle Mobil Uygulama Geliştirme',
                        author: 'John Doe',
                        date: '15 Eylül 2023',
                      ),
                      ForumTopic(
                        icon: Icons.star,
                        title: 'Flutter 2.5 Güncellemesi',
                        author: 'Alice Johnson',
                        date: '5 Eylül 2023',
                      ),
                      ForumTopic(
                        icon: Icons.star,
                        title: 'Flutter 2.5 Güncellemesi',
                        author: 'Alice Johnson',
                        date: '5 Eylül 2023',
                      ),
                      // Diğer popüler konular burada eklenir
                    ],
                  ),
                  ForumSection(title: 'Güncel Konular', topics: [
                    ForumTopic(
                      icon: Icons.fiber_new,
                      title: 'Flutter 2.5 Güncellemesi',
                      author: 'Alice Johnson',
                      date: '5 Eylül 2023',
                    ),
                    ForumTopic(
                      icon: Icons.fiber_new,
                      title: 'Flutter 2.5 Güncellemesi',
                      author: 'Alice Johnson',
                      date: '5 Eylül 2023',
                    ),
                    ForumTopic(
                      icon: Icons.fiber_new,
                      title: 'Flutter 2.5 Güncellemesi',
                      author: 'Alice Johnson',
                      date: '5 Eylül 2023',
                    ),
                    // Diğer güncel konular burada eklenir
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        // Konu tıklanınca yapılacak işlemler buraya eklenir
        // Örneğin, konuyu göstermek için yeni bir sayfa açabilirsiniz.
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
              onPressed: () {
                // Daha fazla göster butonuna tıklandığında yapılacak işlemler buraya eklenir
                // Örneğin, daha fazla konu yüklemek için bir işlem yapabilirsiniz.
              },
              child: Text('Daha Fazla Göster'),
            ),
          ],
        ),
      ],
    );
  }
}
