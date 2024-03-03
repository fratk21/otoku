import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/home/viewmodel/productmodel.dart';
import 'package:otoku/pages/message_screen/messageview_screen.dart';
import 'package:otoku/pages/profile/viewmodel/profile.model.dart';
import 'package:otoku/services/firestore_methods.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:otoku/utils/showsnackbar.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/custombutton.dart';
import 'package:otoku/widgets/indicator.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textmodels.dart';

class profilescreen extends StatefulWidget {
  final String uid;
  const profilescreen({super.key, required this.uid});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen>
    with TickerProviderStateMixin {
  var userData = {};
  int sdataleng = 0;
  double starsavg = 1;
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  bool me = false;
  int selectedIndex = 0;
  TabController? tabController;
  List<String> values = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 1, vsync: this);
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var meSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('products')
          .where('useruid', isEqualTo: widget.uid)
          .get();
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;

      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = meSnap.data()!['following'].contains(widget.uid);
      print(meSnap.data()!['followers'].contains(widget.uid));
      setState(() {});
    } catch (e) {
      print(e);
    }
    values.add(followers.toString());
    values.add(following.toString());
    values.add(postLen.toString());
    print(userData['uid'].toString());
    print(widget.uid);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CustomProgressIndicator(),
          )
        : Scaffold(
            appBar: _buildAppBar(userData['username'].toString()),
            body: Column(
              children: [
                createUserProfileCard(userData['photoUrl'].toString(),
                    "@${userData['username'].toString()}"),
                sizedBoxH(20.0),
                createStatRow(values),
                sizedBoxH(20.0),
                widget.uid == FirebaseAuth.instance.currentUser!.uid
                    ? Container()
                    : buildCustomButtonRow(context, () async {
                        await FireStoreMethods().followUser(
                          FirebaseAuth.instance.currentUser!.uid,
                          userData['uid'],
                        );

                        setState(() {
                          isFollowing = true;
                          followers++;
                        });
                      }, () {
                        PageNavigator.push(
                            context, ChatPage(uid: userData['uid']));
                      }, isFollowing ? "Not a friend" : "Add friend"),
                sizedBoxH(20),
                TabBar(
                  physics: NeverScrollableScrollPhysics(),
                  tabAlignment: TabAlignment.fill,
                  dividerColor: AppColors.transparent,
                  isScrollable: false,
                  controller: tabController,
                  // indicator: BoxDecoration(color: orange),
                  labelColor: AppColors.black,
                  labelStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  unselectedLabelColor: AppColors.black.withOpacity(0.26),
                  onTap: (tapIndex) {
                    setState(() {
                      selectedIndex = tapIndex;
                    });
                  },
                  tabs: [
                    Tab(text: "Product"),
                  ],
                ),
                sizedBoxH(10),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('products')
                              .where('useruid', isEqualTo: widget.uid)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CustomProgressIndicator(),
                              );
                            }
                            List<DocumentSnapshot> products =
                                snapshot.data!.docs;
                            if (products.isEmpty) {
                              return Center(
                                  child: Text("Does not have any products"));
                            } else {
                              return GridView.count(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children:
                                    List.generate(products.length, (index) {
                                  // Her bir ürünü göstermek için bir widget döndürün
                                  return productmodel(
                                    snap: snapshot.data!.docs[index].data(),
                                  );
                                }),
                              );
                            }
                          })
                    ],
                  ),
                ),
              ],
            ));
  }
}

CustomAppBar _buildAppBar(
  String name,
) {
  return CustomAppBar(
      //automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      title: CustomText(
        text: name,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w500,
        ),
        //  alignment: MainAxisAlignment.center,
      ));
}

Widget buildCustomButtonRow(BuildContext context, Function()? addfriend,
    Function()? message, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      customButton(
        onPressed: addfriend,
        text: text,
        context: context,
        width: 0.4,
        height: 0.060,
      ),
      sizedBoxW(10),
      customButton(
        onPressed: message,
        text: "Message",
        context: context,
        width: 0.4,
        height: 0.060,
      ),
    ],
  );
}
