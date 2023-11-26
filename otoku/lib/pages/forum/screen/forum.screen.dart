import 'package:flutter/material.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/pages/forum/viewmodel/forum.viewmodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/search.textfield.dart';

class forumscreen extends StatefulWidget {
  const forumscreen({super.key});

  @override
  State<forumscreen> createState() => _forumscreenState();
}

class _forumscreenState extends State<forumscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Text(
          "OTOKU FORUM",
          style: TextStyle(
              fontFamily: "BlackOpsOne", fontSize: 30, color: AppColors.orange),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: searchtextfield(hinttext: 'Forumda arama yapın...')),
      ),
      body: SingleChildScrollView(
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
