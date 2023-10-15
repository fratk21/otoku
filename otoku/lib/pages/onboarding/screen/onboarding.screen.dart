import 'package:flutter/material.dart';
import 'package:otoku/pages/onboarding/screen/onboarding.page1.dart';
import 'package:otoku/pages/onboarding/screen/onboarding.page2.dart';
import 'package:otoku/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  PageController _controller = PageController();
  bool onlastpage = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onlastpage = (index == 1);
              });
            },
            children: [
              page1(),
              page2(),
            ],
          ),
          Container(
              alignment: Alignment(0, 0.95),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 2,
                    effect: SlideEffect(
                        spacing: 8.0,
                        radius: 5,
                        dotWidth: 60.0,
                        dotHeight: 13.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1,
                        dotColor: gblue,
                        activeDotColor: rose),
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
