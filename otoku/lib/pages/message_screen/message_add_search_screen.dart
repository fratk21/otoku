import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/message_screen/messageview_screen.dart';
import 'package:random_avatar/random_avatar.dart';

class message_add_search_screen extends StatefulWidget {
  const message_add_search_screen({super.key});

  @override
  State<message_add_search_screen> createState() =>
      _message_add_search_screenState();
}

class _message_add_search_screenState extends State<message_add_search_screen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  List<dynamic> following = [];
  List<dynamic> followers = [];
  List<dynamic> uniqueItemsList = [];

  int loading = 0;

  Future gel() async {
    loading = 0;
    var docs = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    following = docs.data()!["following"];
    followers = docs.data()!["followers"];
    uniqueItemsList =
        followers.toSet().where((x) => following.toSet().contains(x)).toList();
    uniqueItemsList.add(FirebaseAuth.instance.currentUser?.uid);
    uniqueItemsList.add(following);
    uniqueItemsList.add(followers);
    loading = 1;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration:
                const InputDecoration(labelText: 'Search for a user...'),
            onFieldSubmitted: (String _) {
              setState(() {
                if (searchController.text.isNotEmpty) {
                  isShowUsers = true;
                } else {
                  isShowUsers = false;
                }
              });
              print(_);
            },
          ),
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // () => Navigator.of(context).push(
                        // MaterialPageRoute(
                        // builder: (context) => ProfileScreen(
                        // uid: (snapshot.data! as dynamic).docs[index]['uid'],
                        //),
                        //),
                      },
                      child: ListTile(
                        leading: RandomAvatar(
                          (snapshot.data! as dynamic)
                              .docs[index]['photoUrl']
                              .toString(),
                          height: 50,
                        ),
                        title: Text(
                          (snapshot.data! as dynamic).docs[index]['username'],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : loading == 0
              ? const Center(child: CircularProgressIndicator())
              : FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .where("uid", whereIn: uniqueItemsList)
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    uid: (snapshot.data! as dynamic).docs[index]
                                        ['uid'],
                                  ),
                                ),
                              );
                              print((snapshot.data! as dynamic).docs[index]
                                  ['uid']);
                            },
                            child: ListTile(
                              leading: RandomAvatar(
                                (snapshot.data! as dynamic)
                                    .docs[index]['photoUrl']
                                    .toString(),
                                height: 50,
                              ),
                              title: Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['username'],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
