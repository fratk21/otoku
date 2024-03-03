import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/message_screen/comps/widget.dart';
import 'package:otoku/pages/message_screen/message_add_search_screen.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/widgets/post_card_message_view.dart';
import 'comps/styles.dart';

class message_screen extends StatefulWidget {
  const message_screen({Key? key}) : super(key: key);
  @override
  State<message_screen> createState() => _message_screenState();
}

class _message_screenState extends State<message_screen> {
  bool open = false;

  @override
  List<dynamic> friendsList = [];
  bool bak = false;
  int loading = 0;
  String username = "";
  String profileimage = "";
  String lastmessage = "";
  int listelenght = 0;
  Future gel() async {
    loading = 0;
    var docs = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    friendsList = docs.data()!["following"];
    friendsList.add(FirebaseAuth.instance.currentUser?.uid);
    var liste = await FirebaseFirestore.instance
        .collection('users')
        .where("uid", whereIn: friendsList)
        .get();

    liste.docs.forEach((element) {
      username = element.data()["username"].toString();
      profileimage = element.data()["photoUrl"].toString();
    });

    var messagebool = await FirebaseFirestore.instance
        .collection("message")
        .where("messageroompeaple",
            arrayContains: FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (messagebool.docs.isEmpty) {
      bak = false;
    } else {
      bak = true;
    }

    print(messagebool.docs.length);

    listelenght = liste.docs.length;
    loading = 1;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Text(
          "OTOKU CHAT",
          style: TextStyle(
            fontFamily: "BlackOpsOne",
            fontSize: 30,
            color: AppColors.orange,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: bak == false
                                ? Center(
                                    child: Text("hiç mesajın yok mesaj gönder"),
                                  )
                                : StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("message")
                                        .where("messageroompeaple",
                                            arrayContains: FirebaseAuth
                                                .instance.currentUser?.uid)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return Postcard_message_view(
                                              username: username,
                                              snap: snapshot.data!.docs[index]
                                                  .data());
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ChatWidgets.searchBar(open)
          ],
        ),
      ),
    );
  }
}
