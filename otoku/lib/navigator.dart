import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoku/pages/add/addForum/view/addForum.dart';
import 'package:otoku/pages/add/addMessage/screen/AddMessage.dart';
import 'package:otoku/pages/add/addProduct/view/add_product.dart';
import 'package:otoku/pages/add/addProduct/view/selectmaincategory.dart';
import 'package:otoku/pages/forum/screen/forum.screen.dart';
import 'package:otoku/pages/home/screen/home.screen.dart';
import 'package:otoku/pages/message_screen/message_add_search_screen.dart';
import 'package:otoku/pages/message_screen/message_screen.dart';
import 'package:otoku/pages/messages/screen/message.screen.dart';
import 'package:otoku/pages/profile/view/profile.dart';
import 'package:otoku/pages/settings/screen/settings.dart';
import 'package:otoku/utils/colors.dart';
import 'package:otoku/utils/pageroutes.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class navigatorscreen extends StatefulWidget {
  const navigatorscreen({Key? key});

  @override
  _navigatorscreenState createState() => _navigatorscreenState();
}

class _navigatorscreenState extends State<navigatorscreen> {
  late PageController _pageController;
  int selectedIndex = 0;
  late Widget fabContent;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
    fabContent = Icon(Icons.add, key: UniqueKey());
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.flashwhite,
      extendBody: true,
      body: buildSafeAreaWithPageView(_pageController, _listOfWidget),
      bottomNavigationBar:
          buildStylishBottomBar(selectedIndex, _pageController, (index) {
        setState(() {
          selectedIndex = index;
          fabContent = getFabContent(index);
        });
      }),
      floatingActionButton: buildFloatingActionButton(fabContent, () {
        PageNavigator.push(
            context,
            selectedIndex == 0
                ? MainCategoriesPage()
                : selectedIndex == 1
                    ? addForum()
                    : selectedIndex == 2
                        ? message_add_search_screen()
                        : selectedIndex == 3
                            ? Settingscreen()
                            : addForum());
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildFloatingActionButton(Widget fabContent, Function() onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.white,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: fabContent,
      ),
    );
  }

  Widget buildSafeAreaWithPageView(
      PageController _pageController, List<Widget> listOfWidget) {
    return SafeArea(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: listOfWidget,
      ),
    );
  }

  List<Widget> _listOfWidget = <Widget>[
    const homescreen(),
    const forumscreen(),
    const message_screen(),
    profilescreen(uid: FirebaseAuth.instance.currentUser!.uid.toString()),
  ];

  Widget getFabContent(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.add, key: UniqueKey());
      case 1:
        return Icon(Icons.post_add_rounded, key: UniqueKey());
      case 2:
        return Icon(Icons.forum_outlined, key: UniqueKey());
      case 3:
        return Icon(Icons.settings_rounded, key: UniqueKey());
      default:
        return Icon(Icons.add, key: UniqueKey());
    }
  }

  Widget buildStylishBottomBar(
      int selectedIndex, PageController _pageController, Function(int) onTap) {
    return StylishBottomBar(
      option: AnimatedBarOptions(
        barAnimation: BarAnimation.fade,
        iconStyle: IconStyle.animated,
      ),
      items: [
        BottomBarItem(
          icon: Icon(CupertinoIcons.house_alt),
          selectedIcon: Icon(CupertinoIcons.house_alt_fill),
          selectedColor: Colors.red,
          unSelectedColor: Colors.orange,
          title: const Text('Home'),
        ),
        BottomBarItem(
          icon: const Icon(CupertinoIcons.chat_bubble_2),
          selectedIcon: const Icon(CupertinoIcons.chat_bubble_2_fill),
          selectedColor: Colors.red,
          unSelectedColor: Colors.purple,
          title: const Text('Forum'),
        ),
        BottomBarItem(
          icon: const Icon(CupertinoIcons.pencil_outline),
          selectedIcon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
          unSelectedColor: Colors.amber,
          selectedColor: Colors.red,
          title: const Text('Message'),
        ),
        BottomBarItem(
          icon: const Icon(
            Icons.person_outline,
          ),
          selectedIcon: const Icon(
            Icons.person,
          ),
          unSelectedColor: Colors.purpleAccent,
          selectedColor: Colors.red,
          title: const Text('Profile'),
        ),
      ],
      hasNotch: true,
      fabLocation: StylishBarFabLocation.center,
      currentIndex: selectedIndex,
      onTap: (index) {
        _pageController.jumpToPage(index);
        onTap(index);
      },
    );
  }
}
