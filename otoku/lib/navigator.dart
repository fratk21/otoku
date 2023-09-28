import 'package:flutter/material.dart';
import 'package:otoku/pages/advert.dart';
import 'package:otoku/pages/forum.dart';
import 'package:otoku/pages/messages.dart';
import 'package:otoku/pages/product.dart';
import 'package:otoku/pages/profile.dart';
import 'package:otoku/utils/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _listOfWidget,
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: navigatorcolor,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            _pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          });
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.shopping_bag),
            title: Text("Shop"),
            selectedColor: orange,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.wifi_tethering),
            title: Text("Forum"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.message),
            title: Text("Message"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

List<Widget> _listOfWidget = <Widget>[
  const productscreen(),
  const forumscreen(),
  ChatScreen(),
  const profilescreen(),
];
