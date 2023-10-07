import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:otoku/pages/forum.dart';
import 'package:otoku/pages/messages.dart';
import 'package:otoku/pages/product.dart';
import 'package:otoku/pages/profile.dart';
import 'package:otoku/utils/colors.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class navigatorscreen extends StatefulWidget {
  const navigatorscreen({super.key});

  @override
  State<navigatorscreen> createState() => _navigatorscreenState();
}

class _navigatorscreenState extends State<navigatorscreen> {
  /// Controller to handle PageView and also handles initial page
  late PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: flashwhite,
      extendBody: true,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _listOfWidget,
        ),
      ),
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          // iconSize: 32,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,
          // opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: Icon(CupertinoIcons.house_alt),
            selectedIcon: Icon(CupertinoIcons.house_alt_fill),
            // selectedColor: Colors.teal,
            backgroundColor: orange,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(CupertinoIcons.chat_bubble_2),
            selectedIcon: const Icon(CupertinoIcons.chat_bubble_2_fill),
            selectedColor: Colors.red,
            unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Forum'),
          ),
          BottomBarItem(
              icon: const Icon(CupertinoIcons.pencil_outline),
              selectedIcon:
                  const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
              backgroundColor: Colors.amber,
              selectedColor: Colors.deepOrangeAccent,
              title: const Text('Message')),
          BottomBarItem(
              icon: const Icon(
                Icons.person_outline,
              ),
              selectedIcon: const Icon(
                Icons.person,
              ),
              backgroundColor: Colors.purpleAccent,
              selectedColor: Colors.deepPurple,
              title: const Text('Profile')),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        //shape: CircleBorder(),
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

List<Widget> _listOfWidget = <Widget>[
  const productscreen(),
  const forumscreen(),
  ChatScreen(),
  const profilescreen(),
];

class AnimatedBottomNavigationBar extends StatelessWidget {
  final List<IconData> icons;
  final int activeIndex;
  final Function(int) onTap;

  AnimatedBottomNavigationBar({
    required this.icons,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: icons.asMap().entries.map((entry) {
            final index = entry.key;
            final icon = entry.value;
            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: index == activeIndex
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: index == activeIndex
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
