import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/profile/viewmodel/profile.model.dart';
import 'package:otoku/widgets/appbarmodel.dart';
import 'package:otoku/model/pagemodel.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/widgets/custombutton.dart';
import 'package:otoku/widgets/sizedbox.dart';
import 'package:otoku/widgets/textmodels.dart';

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

  List<String> values = ["29", "121.9k", "15"];
  @override
  Widget build(BuildContext context) {
    return PageModel(
        appBar: _buildAppBar("Jenny Wilson"),
        body: Column(
          children: [
            createUserProfileCard("assets/image/manga.png", "@Wilson_je"),
            sizedBoxH(20.0),
            createStatRow(values),
            sizedBoxH(20.0),
            buildCustomButtonRow(context, () => null, () => null),
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
                Tab(text: "Sells product"),
              ],
            ),
            sizedBoxH(10),
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

CustomAppBar _buildAppBar(
  String name,
) {
  return CustomAppBar(
      automaticallyImplyLeading: false,
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

Widget buildCustomButtonRow(
    BuildContext context, Function()? addfriend, Function()? message) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      customButton(
        onPressed: addfriend,
        text: "Add Friend",
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
