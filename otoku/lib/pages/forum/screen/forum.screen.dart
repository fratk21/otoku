import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/pages/forum/viewmodel/forum.viewmodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/indicator.dart';

class forumscreen extends StatefulWidget {
  const forumscreen({Key? key});

  @override
  State<forumscreen> createState() => _forumscreenState();
}

class _forumscreenState extends State<forumscreen> {
  final CollectionReference forumEntries =
      FirebaseFirestore.instance.collection('forum');
  TextEditingController search = TextEditingController();

  // Kullanıcı verilerini çekmek için fonksiyon
  Future<Map<String, dynamic>> getUserData(String uid) async {
    // Firestore'dan belirli bir kullanıcının verilerini çekme
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    // Kullanıcı verilerini döndürme
    return userSnapshot.data() as Map<String, dynamic>;
  }

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
            fontFamily: "BlackOpsOne",
            fontSize: 30,
            color: AppColors.orange,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: search,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Forumda arama yapın...',
                      ),
                    ),
                  ),
                  if (search.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        search.clear();
                        Future.delayed(Duration(milliseconds: 100), () {
                          setState(() {});
                        });
                      },
                      child: Icon(Icons.clear),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: forumEntries.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Hata: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text('Hiçbir forum konusu bulunamadı.');
              }

              // Future.wait kullanarak tüm asenkron işlemleri bekleyin
              Future<List<ForumTopic>> getRecentTopics() async {
                List<Future<ForumTopic>> futures = snapshot.data!.docs
                    .where((doc) => (search.text.isEmpty ||
                        doc['forumKonu']
                            .toLowerCase()
                            .contains(search.text.toLowerCase())))
                    .map((doc) async {
                  Map<String, dynamic> userData = await getUserData(doc['uid']);
                  return ForumTopic(
                    icon: Icons.star,
                    title: doc['forumKonu'],
                    author: userData['username'],
                    date: doc['timestamp'].toString(),
                    doc: doc,
                    user: userData,
                  );
                }).toList();

                // Tüm asenkron işlemleri bekleyin
                return await Future.wait(futures);
              }

              return FutureBuilder<List<ForumTopic>>(
                future: getRecentTopics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomProgressIndicator();
                  }

                  List<ForumTopic> recentTopics = snapshot.data ?? [];

                  return Column(
                    children: [
                      ForumSection(
                        title: 'Güncel Konular',
                        topics: recentTopics,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
