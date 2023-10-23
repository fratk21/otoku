import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/widgets/pagemodel.dart';
import 'package:otoku/utils/colors.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen>
    with TickerProviderStateMixin {
  bool me = false;
  int selectedIndex = 0;
  TabController? tabController;
  var listImage = [
    "assets/image/manga.png",
    "assets/image/manga.png",
    "assets/image/manga.png",
    "assets/image/manga.png",
    "assets/image/manga.png",
    "assets/image/manga.png",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return pagemodel(
        AppBar: CustomAppBar(
          autoleading: false,
          backgroundColor: white,
          title: Text(
            "Jenny Wilson",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                size: 30.0,
              ),
            ),
          ],
        ),
        Widget: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/image/manga.png"),
              radius: 70.0,
            ),
            SizedBox(height: 20.0),
            Text(
              "@Wilson_je",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20.0),
                Column(
                  children: [
                    Text(
                      "29",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "İlanlar",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "121.9k",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Yazılar",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "15",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Rozetler",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(width: 20.0),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Follow",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(120.0, 30.0),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Message",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(120.0, 30.0),
                    primary: orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TabBar(
              physics: NeverScrollableScrollPhysics(),
              tabAlignment: TabAlignment.fill,
              dividerColor: Colors.transparent,
              isScrollable: false,
              controller: tabController,
              // indicator: BoxDecoration(color: orange),
              labelColor: Colors.black,
              labelStyle:
                  TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black26,
              onTap: (tapIndex) {
                setState(() {
                  selectedIndex = tapIndex;
                });
              },
              tabs: [
                Tab(text: "Product"),
                Tab(text: "Sells product"),
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(
              flex: 1,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Center(
                    child: Text("You don't have any product"),
                  ),
                  Center(
                    child: Text("You don't have any product"),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
