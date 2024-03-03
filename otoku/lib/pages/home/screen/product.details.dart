import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/profile/view/profile.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/indicator.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import 'package:scroll_page_view/scroll_page.dart';

class productdetailscreen extends StatefulWidget {
  final snap;
  const productdetailscreen({super.key, required this.snap});

  @override
  State<productdetailscreen> createState() => _productdetailscreenState();
}

class _productdetailscreenState extends State<productdetailscreen> {
  List<String> _images = [];
  var userData = {};
  bool isLoading = false;

  void getdata() async {
    setState(() {
      isLoading = true;
    });
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.snap["useruid"])
        .get();
    setState(() {
      userData = userSnap.data()!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _images.addAll(widget.snap["imageUrlList"].cast<String>());
    getdata();
  }

  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CustomProgressIndicator(),
          )
        : PageModel(
            appBar: CustomAppBar(
              elevation: 2,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: ScrollPageView(
                        controller: ScrollPageController(),
                        children:
                            _images.map((image) => _imageView(image)).toList(),
                      ),
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.snap["price"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(widget.snap["productName"].toString()),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_city),
                                Text(
                                    "${widget.snap["country"].toString()},${widget.snap["city"].toString()}")
                              ],
                            ),
                            Text("${widget.snap["creationDate"].toString()}")
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Detaylar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text("Durum"),
                            SizedBox(
                              width: 30,
                            ),
                            Text("${widget.snap["status"].toString()}")
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Açıklama",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(widget.snap["productDescription"].toString()),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        PageNavigator.push(
                            context, profilescreen(uid: userData["uid"]));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RandomAvatar(userData["photoUrl"].toString(),
                                  height: 50),
                              SizedBox(
                                width: 10,
                              ),
                              Text(userData["username"]),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Divider()
                  ],
                ),
              ),
            ));
  }
}

Widget _imageView(String image) {
  return ClipRRect(
    clipBehavior: Clip.antiAlias,
    borderRadius: BorderRadius.circular(8),
    child: Image.network(image, fit: BoxFit.cover),
  );
}
